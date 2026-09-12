import AppKit
import Sparkle

final class AppDelegate: NSObject, NSApplicationDelegate {
    private var window: NSWindow?
    private var settingsRenderer: ChronofaceRendererView?
    // Sparkle auto-updates: the feed serves the same notarized .pkg the
    // manual install uses, so app, extension and legacy saver update together.
    private let updaterController = SPUStandardUpdaterController(
        startingUpdater: true, updaterDelegate: nil, userDriverDelegate: nil
    )
    // Кнопка «My Location» в настройках: CoreLocation доступен только app-таргету,
    // extension получает выбранное место через общие настройки.
    private let locationLookup = LocationLookup()

    func applicationDidFinishLaunching(_ notification: Notification) {
        setupMenu()
        let lookup = locationLookup
        ChronofaceRendererView.locationProvider = { completion in
            lookup.request(completion: completion)
        }

        // Создаём transient renderer чтобы использовать его buildConfigureContent()
        // как основной UI настроек. Renderer владеет target=self у кнопок,
        // держим strong reference.
        let renderer = ChronofaceRendererView(
            frame: NSRect(x: 0, y: 0, width: 100, height: 100),
            isPreview: true
        )
        self.settingsRenderer = renderer
        let (content, size) = renderer.buildConfigureContent()

        let window = NSWindow(
            contentRect: NSRect(origin: .zero, size: size),
            styleMask: [.titled, .closable, .miniaturizable],
            backing: .buffered,
            defer: false
        )
        window.title = "Chronoface"
        window.contentView = content
        window.center()
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        self.window = window
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    // MARK: - Menu

    private func setupMenu() {
        let mainMenu = NSMenu()

        // App menu (по умолчанию macOS показывает имя из CFBundleName)
        let appMenuItem = NSMenuItem()
        mainMenu.addItem(appMenuItem)
        let appMenu = NSMenu()
        appMenuItem.submenu = appMenu

        appMenu.addItem(withTitle: "About Chronoface",
                        action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)),
                        keyEquivalent: "")
        let updatesItem = NSMenuItem(title: "Check for Updates…",
                                     action: #selector(SPUStandardUpdaterController.checkForUpdates(_:)),
                                     keyEquivalent: "")
        updatesItem.target = updaterController
        appMenu.addItem(updatesItem)
        appMenu.addItem(.separator())
        appMenu.addItem(withTitle: "Uninstall Chronoface…",
                        action: #selector(uninstallChronoface(_:)),
                        keyEquivalent: "")
        appMenu.addItem(.separator())
        appMenu.addItem(withTitle: "Hide Chronoface",
                        action: #selector(NSApplication.hide(_:)),
                        keyEquivalent: "h")
        appMenu.addItem(withTitle: "Quit Chronoface",
                        action: #selector(NSApplication.terminate(_:)),
                        keyEquivalent: "q")

        NSApp.mainMenu = mainMenu
    }

    @objc private func uninstallChronoface(_ sender: Any?) {
        let alert = NSAlert()
        alert.messageText = "Uninstall Chronoface?"
        alert.informativeText = "Будут удалены приложение, screensaver, настройки в /Users/Shared/Chronoface/ и связанные кэши. Действие нельзя отменить."
        alert.alertStyle = .warning
        alert.addButton(withTitle: "Uninstall")
        alert.addButton(withTitle: "Cancel")

        guard alert.runModal() == .alertFirstButtonReturn else { return }

        performUninstall()
    }

    /// Native Swift uninstall: убирает user-level вещи через FileManager,
    /// system-level (/Applications, /Library/Screen Savers) через AppleScript
    /// с administrator privileges (macOS показывает встроенный pwd prompt,
    /// без Terminal).
    private func performUninstall() {
        let fm = FileManager.default
        let home = NSHomeDirectory()

        // 1. Закрыть System Settings если открыт (он мог держать наш bundle)
        let killSettings = """
        tell application "System Settings" to quit
        """
        _ = runAppleScript(killSettings)

        // 2. User-level cleanup (без sudo)
        let userPaths = [
            "/Users/Shared/Chronoface",
            "\(home)/Library/Caches/app.perek.rest.ChronofaceApp",
            "\(home)/Library/Caches/com.screensaver.Chronoface.App",
            "\(home)/Library/Preferences/app.perek.rest.ChronofaceApp.plist",
            "\(home)/Library/Preferences/com.screensaver.Chronoface.plist",
            "\(home)/Library/HTTPStorages/com.screensaver.Chronoface.App",
        ]
        for path in userPaths {
            try? fm.removeItem(atPath: path)
        }
        // Application Scripts - в отдельном цикле (glob expansion)
        if let scriptsDir = try? fm.contentsOfDirectory(atPath: "\(home)/Library/Application Scripts") {
            for name in scriptsDir where name.hasPrefix("app.perek.rest.ChronofaceApp")
                                       || name.hasPrefix("com.screensaver.Chronoface") {
                try? fm.removeItem(atPath: "\(home)/Library/Application Scripts/\(name)")
            }
        }

        // 3. Снять extension с регистрации (через pluginkit)
        runShell("/usr/bin/pluginkit",
                 args: ["-e", "ignore", "-i", "app.perek.rest.ChronofaceApp.ChronofaceExtension"])

        // 4. System-level через admin privileges (один pwd prompt на всё)
        let shellCmd = """
        rm -rf '/Applications/Chronoface.app' '/Library/Screen Savers/Chronoface.saver' 2>/dev/null
        pkgutil --forget app.perek.rest.ChronofaceApp 2>/dev/null
        killall WallpaperAgent 2>/dev/null
        killall legacyScreenSaver 2>/dev/null
        exit 0
        """
        let adminScript = """
        do shell script "\(shellCmd.replacingOccurrences(of: "\n", with: " ; "))" with administrator privileges
        """

        if let err = runAppleScript(adminScript) {
            // Юзер мог нажать Cancel в pwd prompt - не fatal
            let alert = NSAlert()
            alert.messageText = "Uninstall partially complete"
            alert.informativeText = "User-данные удалены. /Applications/Chronoface.app не удалён: \(err). Удалите вручную через Finder."
            alert.alertStyle = .warning
            alert.runModal()
            return
        }

        // 5. Success - сообщить и выйти
        let done = NSAlert()
        done.messageText = "Chronoface удалён"
        done.informativeText = "Спасибо что пробовали Chronoface."
        done.alertStyle = .informational
        done.runModal()
        NSApp.terminate(nil)
    }

    @discardableResult
    private func runShell(_ launchPath: String, args: [String]) -> Int32 {
        let p = Process()
        p.launchPath = launchPath
        p.arguments = args
        p.standardOutput = Pipe()
        p.standardError = Pipe()
        do {
            try p.run()
            p.waitUntilExit()
            return p.terminationStatus
        } catch {
            return -1
        }
    }

    /// Возвращает nil при успехе или текст ошибки.
    private func runAppleScript(_ source: String) -> String? {
        guard let script = NSAppleScript(source: source) else { return "Could not compile AppleScript" }
        var errorInfo: NSDictionary?
        script.executeAndReturnError(&errorInfo)
        if let errorInfo = errorInfo,
           let msg = errorInfo[NSAppleScript.errorMessage] as? String {
            return msg
        }
        return nil
    }
}
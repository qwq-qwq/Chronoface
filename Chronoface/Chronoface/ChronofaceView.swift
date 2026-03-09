import ScreenSaver
import AppKit

// MARK: - Theme definition

enum ThemeName: String, CaseIterable {
    case white = "White"
    case turquoise = "Turquoise"
    case glacier = "Glacier"
    case ocean = "Ocean"
    case tennis = "Tennis"
    case signalBlue = "Signal Blue"
    case salmon = "Salmon"
    case yellow = "Yellow"
    case beige = "Beige"
    case pistachio = "Pistachio"
    case lavender = "Lavender"
    case rose = "Rose"
    case skyBlue = "Sky Blue"
    case cream = "Cream"
    case slate = "Slate"
    case noir = "Noir"
}

struct Theme {
    let background: NSColor
    let tickColor: NSColor
    let numberColor: NSColor
    let handColor: NSColor
    let handHighlight: NSColor
    let handShadow: NSColor
    let capsuleBase: NSColor
    let capsuleHighlight: NSColor
    let centerGradientStart: NSColor
    let centerGradientEnd: NSColor
    let centerDot: NSColor
    let secondHand: NSColor

    static func named(_ name: ThemeName) -> Theme {
        switch name {
        case .white:
            return Theme(
                background: NSColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                tickColor: NSColor(white: 0.15, alpha: 1.0),
                numberColor: NSColor(white: 0.15, alpha: 1.0),
                handColor: NSColor(white: 0.91, alpha: 1.0),
                handHighlight: NSColor(white: 1.0, alpha: 0.6),
                handShadow: NSColor(white: 0.0, alpha: 0.15),
                capsuleBase: NSColor(white: 0.85, alpha: 1.0),
                capsuleHighlight: NSColor(white: 1.0, alpha: 0.7),
                centerGradientStart: NSColor(white: 0.96, alpha: 1.0),
                centerGradientEnd: NSColor(white: 0.82, alpha: 1.0),
                centerDot: NSColor(white: 0.75, alpha: 1.0),
                secondHand: NSColor(white: 0.91, alpha: 1.0)
            )
        case .turquoise:
            return Theme(
                background: NSColor(displayP3Red: 0.69, green: 0.89, blue: 0.89, alpha: 1.0),
                tickColor: NSColor(red: 0.08, green: 0.24, blue: 0.28, alpha: 1.0),
                numberColor: NSColor(red: 0.08, green: 0.24, blue: 0.28, alpha: 1.0),
                handColor: NSColor(white: 0.91, alpha: 1.0),
                handHighlight: NSColor(white: 1.0, alpha: 0.6),
                handShadow: NSColor(white: 0.0, alpha: 0.15),
                capsuleBase: NSColor(white: 0.85, alpha: 1.0),
                capsuleHighlight: NSColor(white: 1.0, alpha: 0.7),
                centerGradientStart: NSColor(white: 0.96, alpha: 1.0),
                centerGradientEnd: NSColor(white: 0.82, alpha: 1.0),
                centerDot: NSColor(white: 0.75, alpha: 1.0),
                secondHand: NSColor(white: 0.91, alpha: 1.0)
            )
        case .glacier:
            return Theme(
                background: NSColor(displayP3Red: 0.659, green: 0.718, blue: 0.749, alpha: 1.0),
                tickColor: NSColor(red: 0.12, green: 0.16, blue: 0.20, alpha: 0.8),
                numberColor: NSColor(red: 0.12, green: 0.16, blue: 0.20, alpha: 1.0),
                handColor: NSColor(white: 0.91, alpha: 1.0),
                handHighlight: NSColor(white: 1.0, alpha: 0.6),
                handShadow: NSColor(white: 0.0, alpha: 0.15),
                capsuleBase: NSColor(white: 0.88, alpha: 1.0),
                capsuleHighlight: NSColor(white: 1.0, alpha: 0.7),
                centerGradientStart: NSColor(white: 0.96, alpha: 1.0),
                centerGradientEnd: NSColor(white: 0.82, alpha: 1.0),
                centerDot: NSColor(white: 0.75, alpha: 1.0),
                secondHand: NSColor(white: 0.91, alpha: 1.0)
            )
        case .ocean:
            return Theme(
                background: NSColor(displayP3Red: 0.055, green: 0.125, blue: 0.271, alpha: 1.0),
                tickColor: NSColor(displayP3Red: 0.50, green: 0.88, blue: 0.80, alpha: 0.7),
                numberColor: NSColor(displayP3Red: 0.50, green: 0.88, blue: 0.80, alpha: 0.9),
                handColor: NSColor(white: 0.93, alpha: 1.0),
                handHighlight: NSColor(white: 1.0, alpha: 0.5),
                handShadow: NSColor(white: 0.0, alpha: 0.4),
                capsuleBase: NSColor(white: 0.90, alpha: 1.0),
                capsuleHighlight: NSColor(white: 1.0, alpha: 0.6),
                centerGradientStart: NSColor(white: 0.96, alpha: 1.0),
                centerGradientEnd: NSColor(white: 0.82, alpha: 1.0),
                centerDot: NSColor(white: 0.75, alpha: 1.0),
                secondHand: NSColor(white: 0.93, alpha: 1.0)
            )
        case .tennis:
            return Theme(
                background: NSColor(displayP3Red: 0.0, green: 0.451, blue: 0.263, alpha: 1.0),
                tickColor: NSColor(red: 0.45, green: 0.72, blue: 0.35, alpha: 0.7),
                numberColor: NSColor(red: 0.75, green: 0.86, blue: 0.12, alpha: 1.0),
                handColor: NSColor(white: 0.93, alpha: 1.0),
                handHighlight: NSColor(white: 1.0, alpha: 0.5),
                handShadow: NSColor(white: 0.0, alpha: 0.35),
                capsuleBase: NSColor(white: 0.90, alpha: 1.0),
                capsuleHighlight: NSColor(white: 1.0, alpha: 0.6),
                centerGradientStart: NSColor(white: 0.96, alpha: 1.0),
                centerGradientEnd: NSColor(white: 0.82, alpha: 1.0),
                centerDot: NSColor(white: 0.75, alpha: 1.0),
                secondHand: NSColor(white: 0.93, alpha: 1.0)
            )
        case .signalBlue:
            return Theme(
                background: NSColor(displayP3Red: 0.0, green: 0.624, blue: 0.851, alpha: 1.0),
                tickColor: NSColor(white: 1.0, alpha: 0.65),
                numberColor: NSColor(white: 1.0, alpha: 0.85),
                handColor: NSColor(white: 0.93, alpha: 1.0),
                handHighlight: NSColor(white: 1.0, alpha: 0.5),
                handShadow: NSColor(white: 0.0, alpha: 0.3),
                capsuleBase: NSColor(white: 0.90, alpha: 1.0),
                capsuleHighlight: NSColor(white: 1.0, alpha: 0.6),
                centerGradientStart: NSColor(white: 0.96, alpha: 1.0),
                centerGradientEnd: NSColor(white: 0.82, alpha: 1.0),
                centerDot: NSColor(white: 0.75, alpha: 1.0),
                secondHand: NSColor(white: 0.93, alpha: 1.0)
            )
        case .salmon:
            return Theme(
                background: NSColor(displayP3Red: 0.890, green: 0.694, blue: 0.561, alpha: 1.0),
                tickColor: NSColor(red: 0.28, green: 0.13, blue: 0.08, alpha: 0.8),
                numberColor: NSColor(red: 0.28, green: 0.13, blue: 0.08, alpha: 1.0),
                handColor: NSColor(white: 0.91, alpha: 1.0),
                handHighlight: NSColor(white: 1.0, alpha: 0.6),
                handShadow: NSColor(white: 0.0, alpha: 0.15),
                capsuleBase: NSColor(white: 0.85, alpha: 1.0),
                capsuleHighlight: NSColor(white: 1.0, alpha: 0.7),
                centerGradientStart: NSColor(white: 0.96, alpha: 1.0),
                centerGradientEnd: NSColor(white: 0.82, alpha: 1.0),
                centerDot: NSColor(white: 0.75, alpha: 1.0),
                secondHand: NSColor(white: 0.91, alpha: 1.0)
            )
        case .yellow:
            return Theme(
                background: NSColor(displayP3Red: 0.949, green: 0.745, blue: 0.0, alpha: 1.0),
                tickColor: NSColor(red: 0.30, green: 0.16, blue: 0.0, alpha: 0.85),
                numberColor: NSColor(red: 0.30, green: 0.16, blue: 0.0, alpha: 1.0),
                handColor: NSColor(white: 0.91, alpha: 1.0),
                handHighlight: NSColor(white: 1.0, alpha: 0.6),
                handShadow: NSColor(white: 0.0, alpha: 0.15),
                capsuleBase: NSColor(white: 0.85, alpha: 1.0),
                capsuleHighlight: NSColor(white: 1.0, alpha: 0.7),
                centerGradientStart: NSColor(white: 0.96, alpha: 1.0),
                centerGradientEnd: NSColor(white: 0.82, alpha: 1.0),
                centerDot: NSColor(white: 0.75, alpha: 1.0),
                secondHand: NSColor(white: 0.91, alpha: 1.0)
            )
        case .beige:
            return Theme(
                background: NSColor(displayP3Red: 0.878, green: 0.808, blue: 0.624, alpha: 1.0),
                tickColor: NSColor(red: 0.25, green: 0.18, blue: 0.08, alpha: 0.8),
                numberColor: NSColor(red: 0.25, green: 0.18, blue: 0.08, alpha: 1.0),
                handColor: NSColor(white: 0.91, alpha: 1.0),
                handHighlight: NSColor(white: 1.0, alpha: 0.6),
                handShadow: NSColor(white: 0.0, alpha: 0.15),
                capsuleBase: NSColor(white: 0.85, alpha: 1.0),
                capsuleHighlight: NSColor(white: 1.0, alpha: 0.7),
                centerGradientStart: NSColor(white: 0.96, alpha: 1.0),
                centerGradientEnd: NSColor(white: 0.82, alpha: 1.0),
                centerDot: NSColor(white: 0.75, alpha: 1.0),
                secondHand: NSColor(white: 0.91, alpha: 1.0)
            )
        case .pistachio:
            return Theme(
                background: NSColor(displayP3Red: 0.714, green: 0.769, blue: 0.639, alpha: 1.0),
                tickColor: NSColor(red: 0.14, green: 0.20, blue: 0.10, alpha: 0.8),
                numberColor: NSColor(red: 0.14, green: 0.20, blue: 0.10, alpha: 1.0),
                handColor: NSColor(white: 0.91, alpha: 1.0),
                handHighlight: NSColor(white: 1.0, alpha: 0.6),
                handShadow: NSColor(white: 0.0, alpha: 0.15),
                capsuleBase: NSColor(white: 0.85, alpha: 1.0),
                capsuleHighlight: NSColor(white: 1.0, alpha: 0.7),
                centerGradientStart: NSColor(white: 0.96, alpha: 1.0),
                centerGradientEnd: NSColor(white: 0.82, alpha: 1.0),
                centerDot: NSColor(white: 0.75, alpha: 1.0),
                secondHand: NSColor(white: 0.91, alpha: 1.0)
            )
        case .lavender:
            return Theme(
                background: NSColor(displayP3Red: 0.765, green: 0.788, blue: 0.898, alpha: 1.0),
                tickColor: NSColor(red: 0.12, green: 0.12, blue: 0.28, alpha: 0.8),
                numberColor: NSColor(red: 0.12, green: 0.12, blue: 0.28, alpha: 1.0),
                handColor: NSColor(white: 0.91, alpha: 1.0),
                handHighlight: NSColor(white: 1.0, alpha: 0.6),
                handShadow: NSColor(white: 0.0, alpha: 0.15),
                capsuleBase: NSColor(white: 0.85, alpha: 1.0),
                capsuleHighlight: NSColor(white: 1.0, alpha: 0.7),
                centerGradientStart: NSColor(white: 0.96, alpha: 1.0),
                centerGradientEnd: NSColor(white: 0.82, alpha: 1.0),
                centerDot: NSColor(white: 0.75, alpha: 1.0),
                secondHand: NSColor(white: 0.91, alpha: 1.0)
            )
        case .rose:
            return Theme(
                background: NSColor(displayP3Red: 0.898, green: 0.757, blue: 0.796, alpha: 1.0),
                tickColor: NSColor(red: 0.28, green: 0.08, blue: 0.12, alpha: 0.8),
                numberColor: NSColor(red: 0.28, green: 0.08, blue: 0.12, alpha: 1.0),
                handColor: NSColor(white: 0.91, alpha: 1.0),
                handHighlight: NSColor(white: 1.0, alpha: 0.6),
                handShadow: NSColor(white: 0.0, alpha: 0.15),
                capsuleBase: NSColor(white: 0.85, alpha: 1.0),
                capsuleHighlight: NSColor(white: 1.0, alpha: 0.7),
                centerGradientStart: NSColor(white: 0.96, alpha: 1.0),
                centerGradientEnd: NSColor(white: 0.82, alpha: 1.0),
                centerDot: NSColor(white: 0.75, alpha: 1.0),
                secondHand: NSColor(white: 0.91, alpha: 1.0)
            )
        case .skyBlue:
            return Theme(
                background: NSColor(displayP3Red: 0.733, green: 0.851, blue: 0.941, alpha: 1.0),
                tickColor: NSColor(red: 0.22, green: 0.32, blue: 0.50, alpha: 0.7),
                numberColor: NSColor(red: 0.12, green: 0.20, blue: 0.38, alpha: 1.0),
                handColor: NSColor(white: 0.91, alpha: 1.0),
                handHighlight: NSColor(white: 1.0, alpha: 0.6),
                handShadow: NSColor(white: 0.0, alpha: 0.15),
                capsuleBase: NSColor(white: 0.85, alpha: 1.0),
                capsuleHighlight: NSColor(white: 1.0, alpha: 0.7),
                centerGradientStart: NSColor(white: 0.96, alpha: 1.0),
                centerGradientEnd: NSColor(white: 0.82, alpha: 1.0),
                centerDot: NSColor(white: 0.75, alpha: 1.0),
                secondHand: NSColor(white: 0.91, alpha: 1.0)
            )
        case .cream:
            return Theme(
                background: NSColor(displayP3Red: 0.859, green: 0.851, blue: 0.827, alpha: 1.0),
                tickColor: NSColor(red: 0.20, green: 0.18, blue: 0.14, alpha: 0.8),
                numberColor: NSColor(red: 0.20, green: 0.18, blue: 0.14, alpha: 1.0),
                handColor: NSColor(white: 0.91, alpha: 1.0),
                handHighlight: NSColor(white: 1.0, alpha: 0.6),
                handShadow: NSColor(white: 0.0, alpha: 0.15),
                capsuleBase: NSColor(white: 0.85, alpha: 1.0),
                capsuleHighlight: NSColor(white: 1.0, alpha: 0.7),
                centerGradientStart: NSColor(white: 0.96, alpha: 1.0),
                centerGradientEnd: NSColor(white: 0.82, alpha: 1.0),
                centerDot: NSColor(white: 0.75, alpha: 1.0),
                secondHand: NSColor(white: 0.91, alpha: 1.0)
            )
        case .slate:
            return Theme(
                background: NSColor(displayP3Red: 0.275, green: 0.278, blue: 0.290, alpha: 1.0),
                tickColor: NSColor(white: 0.75, alpha: 0.6),
                numberColor: NSColor(white: 0.85, alpha: 1.0),
                handColor: NSColor(white: 0.93, alpha: 1.0),
                handHighlight: NSColor(white: 1.0, alpha: 0.5),
                handShadow: NSColor(white: 0.0, alpha: 0.4),
                capsuleBase: NSColor(white: 0.80, alpha: 1.0),
                capsuleHighlight: NSColor(white: 1.0, alpha: 0.5),
                centerGradientStart: NSColor(white: 0.96, alpha: 1.0),
                centerGradientEnd: NSColor(white: 0.82, alpha: 1.0),
                centerDot: NSColor(white: 0.75, alpha: 1.0),
                secondHand: NSColor(white: 0.93, alpha: 1.0)
            )
        case .noir:
            return Theme(
                background: NSColor(displayP3Red: 0.055, green: 0.055, blue: 0.059, alpha: 1.0),
                tickColor: NSColor(white: 0.70, alpha: 0.6),
                numberColor: NSColor(white: 0.85, alpha: 1.0),
                handColor: NSColor(white: 0.93, alpha: 1.0),
                handHighlight: NSColor(white: 1.0, alpha: 0.4),
                handShadow: NSColor(white: 0.0, alpha: 0.5),
                capsuleBase: NSColor(white: 0.75, alpha: 1.0),
                capsuleHighlight: NSColor(white: 1.0, alpha: 0.4),
                centerGradientStart: NSColor(white: 0.96, alpha: 1.0),
                centerGradientEnd: NSColor(white: 0.82, alpha: 1.0),
                centerDot: NSColor(white: 0.75, alpha: 1.0),
                secondHand: NSColor(white: 0.93, alpha: 1.0)
            )
        }
    }
}

// MARK: - Movement type

enum MovementType: String, CaseIterable {
    case quartz = "Quartz"
    case mechanical = "Mechanical"
    case digital = "Digital"
}

// MARK: - Settings persistence

enum SettingsStore {
    private static let themeKey = "ChronofaceTheme"
    private static let movementKey = "ChronofaceMovement"
    private static let showDateKey = "ChronofaceShowDate"

    static var currentTheme: ThemeName {
        get {
            if let raw = UserDefaults.standard.string(forKey: themeKey),
               let name = ThemeName(rawValue: raw) {
                return name
            }
            return .turquoise
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: themeKey)
        }
    }

    static var currentMovement: MovementType {
        get {
            if let raw = UserDefaults.standard.string(forKey: movementKey),
               let m = MovementType(rawValue: raw) {
                return m
            }
            return .digital
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: movementKey)
        }
    }

    static var showDate: Bool {
        get {
            if UserDefaults.standard.object(forKey: showDateKey) == nil {
                return true
            }
            return UserDefaults.standard.bool(forKey: showDateKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: showDateKey)
        }
    }

    private static let showTempKey = "ChronofaceShowTemp"

    static var showTemperature: Bool {
        get {
            if UserDefaults.standard.object(forKey: showTempKey) == nil {
                return true
            }
            return UserDefaults.standard.bool(forKey: showTempKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: showTempKey)
        }
    }
}

// MARK: - Main screensaver view

class ChronofaceView: ScreenSaverView {

    private(set) var theme: Theme
    private(set) var movement: MovementType
    private(set) var showDate: Bool
    private(set) var showTemperature: Bool

    // Weather data
    private var currentTemperature: String?
    private var currentCity: String?
    private var lastWeatherFetch: Date?
    private var cachedLat: Double?
    private var cachedLon: Double?
    private var isFetchingWeather = false

    // MARK: - Initialization

    override init?(frame: NSRect, isPreview: Bool) {
        theme = Theme.named(SettingsStore.currentTheme)
        movement = SettingsStore.currentMovement
        showDate = SettingsStore.showDate
        showTemperature = SettingsStore.showTemperature
        super.init(frame: frame, isPreview: isPreview)
        animationTimeInterval = 1.0 / 30.0
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func applyTheme(_ name: ThemeName) {
        SettingsStore.currentTheme = name
        theme = Theme.named(name)
        setNeedsDisplay(bounds)
    }

    // MARK: - Lifecycle

    override func startAnimation() {
        super.startAnimation()
        if showTemperature {
            fetchWeatherIfNeeded()
        }
    }

    override func stopAnimation() {
        super.stopAnimation()
    }

    override var hasConfigureSheet: Bool {
        return true
    }

    override var configureSheet: NSWindow? {
        let cols = 8
        let circleSize: CGFloat = 36
        let hSpacing: CGFloat = 10
        let labelHeight: CGFloat = 12
        let marginX: CGFloat = 24
        let gap: CGFloat = 18 // uniform gap between all sections
        let windowWidth = marginX * 2 + CGFloat(cols) * circleSize + CGFloat(cols - 1) * hSpacing

        // Layout from bottom: OK, Movement, Checkboxes, Row1, Row0, Theme label
        let okH: CGFloat = 28, movH: CGFloat = 24, cbH: CGFloat = 20, themeH: CGFloat = 20
        let rowH = circleSize + 1 + labelHeight // circle + gap + label
        let windowHeight = 10 + okH + gap + movH + gap + cbH + gap + rowH + gap + rowH + gap + themeH + 10

        let window = NSPanel(
            contentRect: NSRect(x: 0, y: 0, width: windowWidth, height: windowHeight),
            styleMask: [.titled, .closable],
            backing: .buffered,
            defer: false
        )
        window.title = "Chronoface"

        let contentView = NSView(frame: NSRect(x: 0, y: 0, width: windowWidth, height: windowHeight))

        // Positions from bottom up
        let okY: CGFloat = 10
        let movY = okY + okH + gap
        let cbY = movY + movH + gap
        let row1LabelY = cbY + cbH + gap
        let row1CircleY = row1LabelY + labelHeight + 1
        let row0LabelY = row1CircleY + circleSize + gap
        let row0CircleY = row0LabelY + labelHeight + 1
        let themeLabelY = row0CircleY + circleSize + gap

        // Theme label
        let label = NSTextField(labelWithString: "Theme:")
        label.font = NSFont.systemFont(ofSize: 13, weight: .medium)
        label.frame = NSRect(x: 20, y: themeLabelY, width: 380, height: themeH)
        contentView.addSubview(label)

        // Theme circles — 2 rows of 8
        let allThemes = ThemeName.allCases
        let rowWidth = CGFloat(cols) * circleSize + CGFloat(cols - 1) * hSpacing
        let startX = (windowWidth - rowWidth) / 2
        let circleYForRow = [row0CircleY, row1CircleY]
        let labelYForRow = [row0LabelY, row1LabelY]

        for (i, name) in allThemes.enumerated() {
            let t = Theme.named(name)
            let col = i % cols
            let row = i / cols
            let x = startX + CGFloat(col) * (circleSize + hSpacing)

            let button = NSButton(frame: NSRect(x: x, y: circleYForRow[row], width: circleSize, height: circleSize))
            button.bezelStyle = .regularSquare
            button.isBordered = false
            button.title = ""
            button.tag = i
            button.target = self
            button.action = #selector(themeButtonClicked(_:))
            button.wantsLayer = true
            button.layer?.cornerRadius = circleSize / 2
            button.layer?.backgroundColor = t.background.cgColor
            button.layer?.borderWidth = name == SettingsStore.currentTheme ? 3 : 1
            button.layer?.borderColor = name == SettingsStore.currentTheme
                ? NSColor.controlAccentColor.cgColor
                : NSColor.separatorColor.cgColor
            contentView.addSubview(button)

            let nameLabel = NSTextField(labelWithString: name.rawValue)
            nameLabel.font = NSFont.systemFont(ofSize: 8)
            nameLabel.alignment = .center
            nameLabel.frame = NSRect(x: x - 6, y: labelYForRow[row], width: circleSize + 12, height: labelHeight)
            contentView.addSubview(nameLabel)
        }

        // Show date checkbox
        let dateCheckbox = NSButton(checkboxWithTitle: "Show date", target: self, action: #selector(showDateChanged(_:)))
        dateCheckbox.state = SettingsStore.showDate ? .on : .off
        dateCheckbox.frame = NSRect(x: 20, y: cbY, width: 120, height: cbH)
        contentView.addSubview(dateCheckbox)

        // Show temperature checkbox
        let tempCheckbox = NSButton(checkboxWithTitle: "Show temperature", target: self, action: #selector(showTempChanged(_:)))
        tempCheckbox.state = SettingsStore.showTemperature ? .on : .off
        tempCheckbox.frame = NSRect(x: 160, y: cbY, width: 200, height: cbH)
        contentView.addSubview(tempCheckbox)

        // Movement label
        let movementLabel = NSTextField(labelWithString: "Movement:")
        movementLabel.font = NSFont.systemFont(ofSize: 13, weight: .medium)
        movementLabel.frame = NSRect(x: 20, y: movY + 2, width: 80, height: 20)
        contentView.addSubview(movementLabel)

        // Movement segmented control
        let segment = NSSegmentedControl(labels: MovementType.allCases.map { $0.rawValue },
                                         trackingMode: .selectOne,
                                         target: self,
                                         action: #selector(movementChanged(_:)))
        segment.frame = NSRect(x: 105, y: movY, width: windowWidth - 125, height: movH)
        segment.selectedSegment = MovementType.allCases.firstIndex(of: SettingsStore.currentMovement) ?? 2
        contentView.addSubview(segment)

        // OK button
        let okButton = NSButton(title: "OK", target: self, action: #selector(closeConfigSheet(_:)))
        okButton.bezelStyle = .rounded
        okButton.keyEquivalent = "\r"
        okButton.frame = NSRect(x: windowWidth - 92, y: okY, width: 72, height: okH)
        contentView.addSubview(okButton)

        window.contentView = contentView
        return window
    }

    @objc private func themeButtonClicked(_ sender: NSButton) {
        let allThemes = ThemeName.allCases
        guard sender.tag < allThemes.count else { return }
        let name = allThemes[sender.tag]
        applyTheme(name)

        // Update circle borders
        if let contentView = sender.superview {
            for case let button as NSButton in contentView.subviews where button.layer?.cornerRadius == 18 {
                let isSelected = button.tag == sender.tag
                button.layer?.borderWidth = isSelected ? 3 : 1
                button.layer?.borderColor = isSelected
                    ? NSColor.controlAccentColor.cgColor
                    : NSColor.separatorColor.cgColor
            }
        }
    }

    @objc private func showDateChanged(_ sender: NSButton) {
        showDate = sender.state == .on
        SettingsStore.showDate = showDate
    }

    @objc private func movementChanged(_ sender: NSSegmentedControl) {
        let allMovements = MovementType.allCases
        guard sender.selectedSegment < allMovements.count else { return }
        let m = allMovements[sender.selectedSegment]
        movement = m
        SettingsStore.currentMovement = m
    }

    @objc private func showTempChanged(_ sender: NSButton) {
        showTemperature = sender.state == .on
        SettingsStore.showTemperature = showTemperature
        if showTemperature {
            fetchWeatherIfNeeded()
        }
    }

    @objc private func closeConfigSheet(_ sender: NSButton) {
        guard let window = sender.window else { return }
        window.sheetParent?.endSheet(window)
    }

    // MARK: - Weather fetching

    private func fetchWeatherIfNeeded() {
        if let last = lastWeatherFetch, Date().timeIntervalSince(last) < 30 * 60 {
            return
        }
        guard !isFetchingWeather else { return }
        isFetchingWeather = true

        if let lat = cachedLat, let lon = cachedLon {
            fetchTemperature(lat: lat, lon: lon)
        } else {
            fetchLocation()
        }
    }

    private func fetchLocation() {
        guard let url = URL(string: "https://ipwho.is/") else {
            isFetchingWeather = false
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let lat = json["latitude"] as? Double,
                  let lon = json["longitude"] as? Double else {
                DispatchQueue.main.async { self?.isFetchingWeather = false }
                return
            }
            let city = json["city"] as? String
            DispatchQueue.main.async {
                self.cachedLat = lat
                self.cachedLon = lon
                self.currentCity = city
            }
            self.fetchTemperature(lat: lat, lon: lon)
        }.resume()
    }

    private func fetchTemperature(lat: Double, lon: Double) {
        let urlStr = "https://api.open-meteo.com/v1/forecast?latitude=\(lat)&longitude=\(lon)&current=temperature_2m"
        guard let url = URL(string: urlStr) else {
            isFetchingWeather = false
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            DispatchQueue.main.async {
                self?.isFetchingWeather = false
                guard let data = data, error == nil,
                      let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let current = json["current"] as? [String: Any],
                      let temp = current["temperature_2m"] as? Double else {
                    return
                }
                self?.currentTemperature = String(format: "%.0f°", temp)
                self?.lastWeatherFetch = Date()
            }
        }.resume()
    }

    // MARK: - Drawing

    override func draw(_ rect: NSRect) {
        guard let ctx = NSGraphicsContext.current?.cgContext else { return }

        let width = bounds.width
        let height = bounds.height
        let cx = width / 2.0
        let cy = height / 2.0
        let radius = min(width, height) * 0.44

        // Background
        ctx.setFillColor(theme.background.cgColor)
        ctx.fill(bounds)

        let now = Date()
        let calendar = Calendar.current
        let hours = CGFloat(calendar.component(.hour, from: now) % 12)
        let minutes = CGFloat(calendar.component(.minute, from: now))
        let seconds = CGFloat(calendar.component(.second, from: now))
        let nanoseconds = CGFloat(calendar.component(.nanosecond, from: now))
        let fractionalSeconds = nanoseconds / 1_000_000_000.0

        // Second hand position depends on movement type
        let secondValue: CGFloat
        switch movement {
        case .quartz:
            // Tick once per second — no fractional part
            secondValue = seconds
        case .mechanical:
            // 28,800 bph = 8 beats per second
            let beats = floor(fractionalSeconds * 8.0) / 8.0
            secondValue = seconds + beats
        case .digital:
            // Smooth continuous motion
            secondValue = seconds + fractionalSeconds
        }

        drawMinuteTicks(ctx: ctx, cx: cx, cy: cy, radius: radius)
        drawHourCapsules(ctx: ctx, cx: cx, cy: cy, radius: radius)
        drawHourNumbers(ctx: ctx, cx: cx, cy: cy, radius: radius)
        drawMinuteNumbers(ctx: ctx, cx: cx, cy: cy, radius: radius)
        if showDate {
            drawDateWindow(ctx: ctx, cx: cx, cy: cy, radius: radius, date: now)
        }

        let hourAngle = ((hours + minutes / 60.0) / 12.0) * .pi * 2.0
        let minuteAngle = ((minutes + secondValue / 60.0) / 60.0) * .pi * 2.0
        let secondAngle = (secondValue / 60.0) * .pi * 2.0

        drawHand(ctx: ctx, cx: cx, cy: cy, angle: hourAngle,
                 length: radius * 0.48, width: radius * 0.045, tailLength: radius * 0.08)
        drawHand(ctx: ctx, cx: cx, cy: cy, angle: minuteAngle,
                 length: radius * 0.68, width: radius * 0.035, tailLength: radius * 0.08)
        drawSecondHand(ctx: ctx, cx: cx, cy: cy, angle: secondAngle, radius: radius)
        drawCenterDot(ctx: ctx, cx: cx, cy: cy, radius: radius)

        if showTemperature, let temp = currentTemperature {
            drawTemperature(ctx: ctx, width: width, height: height, text: temp)
        }
    }

    override func animateOneFrame() {
        if showTemperature {
            fetchWeatherIfNeeded()
        }
        setNeedsDisplay(bounds)
    }

    // MARK: - Drawing helpers

    private func polarToPoint(cx: CGFloat, cy: CGFloat, angle: CGFloat, r: CGFloat) -> CGPoint {
        let a = angle - .pi / 2.0
        return CGPoint(x: cx + cos(a) * r, y: cy - sin(a) * r)
    }

    // MARK: - Minute tick marks

    private func drawMinuteTicks(ctx: CGContext, cx: CGFloat, cy: CGFloat, radius: CGFloat) {
        for i in 0..<60 {
            if i % 5 == 0 { continue }

            let angle = (CGFloat(i) / 60.0) * .pi * 2.0
            let inner = polarToPoint(cx: cx, cy: cy, angle: angle, r: radius * 0.88)
            let outer = polarToPoint(cx: cx, cy: cy, angle: angle, r: radius * 0.92)

            ctx.setStrokeColor(theme.tickColor.cgColor)
            ctx.setLineWidth(radius * 0.012)
            ctx.setLineCap(.round)
            ctx.move(to: inner)
            ctx.addLine(to: outer)
            ctx.strokePath()
        }
    }

    // MARK: - Hour capsule markers (3D raised effect)

    private func drawHourCapsules(ctx: CGContext, cx: CGFloat, cy: CGFloat, radius: CGFloat) {
        let capsuleWidth = radius * 0.04

        for i in 0..<12 {
            let angle = (CGFloat(i) / 12.0) * .pi * 2.0
            let inner = polarToPoint(cx: cx, cy: cy, angle: angle, r: radius * 0.78)
            let outer = polarToPoint(cx: cx, cy: cy, angle: angle, r: radius * 0.92)

            ctx.saveGState()
            ctx.setShadow(
                offset: CGSize(width: capsuleWidth * 0.2, height: -capsuleWidth * 0.4),
                blur: capsuleWidth * 1.2,
                color: theme.handShadow.cgColor
            )
            ctx.setStrokeColor(theme.capsuleBase.cgColor)
            ctx.setLineWidth(capsuleWidth)
            ctx.setLineCap(.round)
            ctx.move(to: inner)
            ctx.addLine(to: outer)
            ctx.strokePath()
            ctx.restoreGState()

            let perpAngle = angle - .pi / 2.0
            let a = perpAngle - .pi / 2.0
            let dx = cos(a) * capsuleWidth * 0.2
            let dy = -sin(a) * capsuleWidth * 0.2

            ctx.setStrokeColor(theme.capsuleHighlight.cgColor)
            ctx.setLineWidth(capsuleWidth * 0.3)
            ctx.setLineCap(.round)
            ctx.move(to: CGPoint(x: inner.x + dx, y: inner.y + dy))
            ctx.addLine(to: CGPoint(x: outer.x + dx, y: outer.y + dy))
            ctx.strokePath()
        }
    }

    // MARK: - Hour numbers

    private func drawHourNumbers(ctx: CGContext, cx: CGFloat, cy: CGFloat, radius: CGFloat) {
        let fontSize = radius * 0.14
        let font = NSFont(name: "Futura-Bold", size: fontSize) ?? NSFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: theme.numberColor
        ]

        let numbers = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

        for (i, num) in numbers.enumerated() {
            let angle = (CGFloat(i) / 12.0) * .pi * 2.0
            let pos = polarToPoint(cx: cx, cy: cy, angle: angle, r: radius * 0.65)

            let text = "\(num)"
            let size = (text as NSString).size(withAttributes: attributes)
            let drawPoint = CGPoint(x: pos.x - size.width / 2.0, y: pos.y - size.height / 2.0)
            (text as NSString).draw(at: drawPoint, withAttributes: attributes)
        }
    }

    // MARK: - Minute numbers (outer ring)

    private func drawMinuteNumbers(ctx: CGContext, cx: CGFloat, cy: CGFloat, radius: CGFloat) {
        let fontSize = radius * 0.065
        let font = NSFont(name: "Futura-Medium", size: fontSize) ?? NSFont.systemFont(ofSize: fontSize, weight: .medium)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: theme.numberColor
        ]

        let numbers = [60, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]

        for (i, num) in numbers.enumerated() {
            let angle = (CGFloat(i) / 12.0) * .pi * 2.0
            let pos = polarToPoint(cx: cx, cy: cy, angle: angle, r: radius * 1.02)

            let text = String(format: "%02d", num)
            let size = (text as NSString).size(withAttributes: attributes)
            let drawPoint = CGPoint(x: pos.x - size.width / 2.0, y: pos.y - size.height / 2.0)
            (text as NSString).draw(at: drawPoint, withAttributes: attributes)
        }
    }

    // MARK: - Clock hands with 3D effect

    private func drawHand(ctx: CGContext, cx: CGFloat, cy: CGFloat,
                          angle: CGFloat, length: CGFloat, width: CGFloat, tailLength: CGFloat) {
        let tip = polarToPoint(cx: cx, cy: cy, angle: angle, r: length)
        let tail = polarToPoint(cx: cx, cy: cy, angle: angle + .pi, r: tailLength)

        ctx.saveGState()
        ctx.setShadow(
            offset: CGSize(width: width * 0.3, height: -width * 0.5),
            blur: width * 1.5,
            color: theme.handShadow.cgColor
        )
        ctx.setStrokeColor(theme.handColor.cgColor)
        ctx.setLineWidth(width)
        ctx.setLineCap(.round)
        ctx.move(to: tail)
        ctx.addLine(to: tip)
        ctx.strokePath()
        ctx.restoreGState()

        let perpAngle = angle - .pi / 2.0
        let a = perpAngle - .pi / 2.0
        let dx = cos(a) * width * 0.15
        let dy = -sin(a) * width * 0.15

        ctx.setStrokeColor(theme.handHighlight.cgColor)
        ctx.setLineWidth(width * 0.25)
        ctx.setLineCap(.round)
        ctx.move(to: CGPoint(x: tail.x + dx, y: tail.y + dy))
        ctx.addLine(to: CGPoint(x: tip.x + dx, y: tip.y + dy))
        ctx.strokePath()
    }

    // MARK: - Second hand

    private func drawSecondHand(ctx: CGContext, cx: CGFloat, cy: CGFloat,
                                angle: CGFloat, radius: CGFloat) {
        let tip = polarToPoint(cx: cx, cy: cy, angle: angle, r: radius * 0.78)
        let tail = polarToPoint(cx: cx, cy: cy, angle: angle + .pi, r: radius * 0.15)

        ctx.setStrokeColor(theme.secondHand.cgColor)
        ctx.setLineWidth(radius * 0.01)
        ctx.setLineCap(.round)
        ctx.move(to: tail)
        ctx.addLine(to: tip)
        ctx.strokePath()
    }

    // MARK: - Date window at 3 o'clock

    private func drawDateWindow(ctx: CGContext, cx: CGFloat, cy: CGFloat, radius: CGFloat, date: Date) {
        let day = Calendar.current.component(.day, from: date)
        let text = "\(day)"

        let fontSize = radius * 0.075
        let font = NSFont(name: "Futura-Medium", size: fontSize) ?? NSFont.systemFont(ofSize: fontSize, weight: .medium)

        let windowW = radius * 0.13
        let windowH = radius * 0.09
        let windowX = cx + radius * 0.38 - windowW / 2
        let windowY = cy - windowH / 2
        let cornerR = radius * 0.012

        // Perceived brightness using ITU-R BT.601 luma formula:
        // Y = R×0.299 + G×0.587 + B×0.114
        // Coefficients reflect human eye sensitivity (green > red > blue).
        // Result 0..1; threshold 0.4 separates dark/light themes.
        var bgBrightness: CGFloat = 1.0
        if let rgb = theme.background.usingColorSpace(.deviceRGB) {
            bgBrightness = rgb.redComponent * 0.299 + rgb.greenComponent * 0.587 + rgb.blueComponent * 0.114
        }
        let isDark = bgBrightness < 0.4

        let windowRect = CGRect(x: windowX, y: windowY, width: windowW, height: windowH)
        let bgPath = CGPath(roundedRect: windowRect, cornerWidth: cornerR, cornerHeight: cornerR, transform: nil)

        // Window background — adapt for dark/light themes
        let windowBg: CGColor
        let textColor: NSColor
        if isDark {
            // Darker than background — looks recessed, not floating
            var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
            if let rgb = theme.background.usingColorSpace(.deviceRGB) {
                r = rgb.redComponent; g = rgb.greenComponent; b = rgb.blueComponent
            }
            windowBg = NSColor(red: r * 0.55, green: g * 0.55, blue: b * 0.55, alpha: 1.0).cgColor
            textColor = NSColor(white: 0.88, alpha: 1.0)
        } else {
            windowBg = NSColor.white.withAlphaComponent(0.92).cgColor
            textColor = NSColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0)
        }

        let colorSpace = CGColorSpaceCreateDeviceRGB()

        if isDark {
            // Dark theme: inset effect — no outer shadow, beveled edges
            ctx.addPath(bgPath)
            ctx.setFillColor(windowBg)
            ctx.fillPath()

            // Inner shadows clipped to window shape
            ctx.saveGState()
            ctx.addPath(bgPath)
            ctx.clip()

            // Top inner shadow (darkness falls into the recess)
            let insetH = windowH * 0.35
            let topShadowColors = [CGColor(gray: 0.0, alpha: 0.4), CGColor(gray: 0.0, alpha: 0.0)]
            if let grad = CGGradient(colorsSpace: colorSpace, colors: topShadowColors as CFArray, locations: [0.0, 1.0]) {
                ctx.drawLinearGradient(grad,
                    start: CGPoint(x: windowX, y: windowY + windowH),
                    end: CGPoint(x: windowX, y: windowY + windowH - insetH),
                    options: [])
            }

            // Bottom inner highlight (light catches the lower lip)
            let bottomH = windowH * 0.25
            let bottomColors = [CGColor(gray: 1.0, alpha: 0.0), CGColor(gray: 1.0, alpha: 0.08)]
            if let grad = CGGradient(colorsSpace: colorSpace, colors: bottomColors as CFArray, locations: [0.0, 1.0]) {
                ctx.drawLinearGradient(grad,
                    start: CGPoint(x: windowX, y: windowY + bottomH),
                    end: CGPoint(x: windowX, y: windowY),
                    options: [])
            }

            // Left inner shadow
            let leftW = windowW * 0.2
            let leftColors = [CGColor(gray: 0.0, alpha: 0.2), CGColor(gray: 0.0, alpha: 0.0)]
            if let grad = CGGradient(colorsSpace: colorSpace, colors: leftColors as CFArray, locations: [0.0, 1.0]) {
                ctx.drawLinearGradient(grad,
                    start: CGPoint(x: windowX, y: windowY),
                    end: CGPoint(x: windowX + leftW, y: windowY),
                    options: [])
            }
            ctx.restoreGState()

            // Beveled border: dark top-left, light bottom-right
            // Top edge (dark)
            ctx.saveGState()
            ctx.addPath(bgPath)
            ctx.clip()
            ctx.setStrokeColor(CGColor(gray: 0.0, alpha: 0.35))
            ctx.setLineWidth(1.0)
            ctx.move(to: CGPoint(x: windowX + cornerR, y: windowY + windowH))
            ctx.addLine(to: CGPoint(x: windowX + windowW - cornerR, y: windowY + windowH))
            ctx.strokePath()
            // Bottom edge (light)
            ctx.setStrokeColor(CGColor(gray: 1.0, alpha: 0.1))
            ctx.move(to: CGPoint(x: windowX + cornerR, y: windowY))
            ctx.addLine(to: CGPoint(x: windowX + windowW - cornerR, y: windowY))
            ctx.strokePath()
            ctx.restoreGState()
        } else {
            // Light theme: outer shadow for subtle depth
            ctx.saveGState()
            ctx.setShadow(
                offset: CGSize(width: radius * 0.003, height: -radius * 0.005),
                blur: radius * 0.012,
                color: theme.handShadow.cgColor
            )
            ctx.addPath(bgPath)
            ctx.setFillColor(windowBg)
            ctx.fillPath()
            ctx.restoreGState()

            // Inner top shadow
            ctx.saveGState()
            ctx.addPath(bgPath)
            ctx.clip()
            let insetH = windowH * 0.3
            let shadowColors = [CGColor(gray: 0.0, alpha: 0.12), CGColor(gray: 0.0, alpha: 0.0)]
            if let grad = CGGradient(colorsSpace: colorSpace, colors: shadowColors as CFArray, locations: [0.0, 1.0]) {
                ctx.drawLinearGradient(grad,
                    start: CGPoint(x: windowX, y: windowY + windowH),
                    end: CGPoint(x: windowX, y: windowY + windowH - insetH),
                    options: [])
            }
            // Bottom highlight
            let bottomH = windowH * 0.25
            let hlColors = [CGColor(gray: 1.0, alpha: 0.0), CGColor(gray: 1.0, alpha: 0.2)]
            if let grad = CGGradient(colorsSpace: colorSpace, colors: hlColors as CFArray, locations: [0.0, 1.0]) {
                ctx.drawLinearGradient(grad,
                    start: CGPoint(x: windowX, y: windowY + bottomH),
                    end: CGPoint(x: windowX, y: windowY),
                    options: [])
            }
            ctx.restoreGState()

            // Border
            ctx.addPath(bgPath)
            ctx.setStrokeColor(theme.numberColor.withAlphaComponent(0.18).cgColor)
            ctx.setLineWidth(0.5)
            ctx.strokePath()
        }

        // Date text
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: textColor
        ]
        let size = (text as NSString).size(withAttributes: attributes)
        let textPoint = CGPoint(
            x: windowX + (windowW - size.width) / 2,
            y: windowY + (windowH - size.height) / 2
        )
        (text as NSString).draw(at: textPoint, withAttributes: attributes)
    }

    // MARK: - Temperature display

    private func drawTemperature(ctx: CGContext, width: CGFloat, height: CGFloat, text: String) {
        let minSide = min(width, height)
        let margin = minSide * 0.05
        let rightEdge = width - margin

        // Perceived brightness (ITU-R BT.601 luma: Y = R×0.299 + G×0.587 + B×0.114).
        // On dark backgrounds text needs higher opacity (0.7) to stay readable;
        // on light backgrounds lower opacity (0.5) keeps it subtle.
        var bgBrightness: CGFloat = 1.0
        if let rgb = theme.background.usingColorSpace(.deviceRGB) {
            bgBrightness = rgb.redComponent * 0.299 + rgb.greenComponent * 0.587 + rgb.blueComponent * 0.114
        }
        let alpha: CGFloat = bgBrightness < 0.4 ? 0.7 : 0.5

        // Temperature (bottom)
        let tempFontSize = minSide * 0.032
        let tempFont = NSFont(name: "Futura-Medium", size: tempFontSize) ?? NSFont.systemFont(ofSize: tempFontSize, weight: .medium)
        let tempAttrs: [NSAttributedString.Key: Any] = [
            .font: tempFont,
            .foregroundColor: theme.numberColor.withAlphaComponent(alpha)
        ]
        let tempSize = (text as NSString).size(withAttributes: tempAttrs)
        (text as NSString).draw(at: CGPoint(x: rightEdge - tempSize.width, y: margin), withAttributes: tempAttrs)

        // City name (above temperature)
        if let city = currentCity {
            let cityFontSize = minSide * 0.018
            let cityFont = NSFont(name: "Futura-Medium", size: cityFontSize) ?? NSFont.systemFont(ofSize: cityFontSize, weight: .medium)
            let cityAttrs: [NSAttributedString.Key: Any] = [
                .font: cityFont,
                .foregroundColor: theme.numberColor.withAlphaComponent(alpha * 0.7)
            ]
            let citySize = (city as NSString).size(withAttributes: cityAttrs)
            let cityY = margin + tempSize.height + minSide * 0.004
            (city as NSString).draw(at: CGPoint(x: rightEdge - citySize.width, y: cityY), withAttributes: cityAttrs)
        }
    }

    // MARK: - Center dot with gradient

    private func drawCenterDot(ctx: CGContext, cx: CGFloat, cy: CGFloat, radius: CGFloat) {
        let dotRadius = radius * 0.035
        let dotRect = CGRect(
            x: cx - dotRadius, y: cy - dotRadius,
            width: dotRadius * 2, height: dotRadius * 2
        )

        ctx.saveGState()
        ctx.addEllipse(in: dotRect)
        ctx.clip()

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        if let gradient = CGGradient(
            colorsSpace: colorSpace,
            colors: [theme.centerGradientStart.cgColor, theme.centerGradientEnd.cgColor] as CFArray,
            locations: [0.0, 1.0]
        ) {
            ctx.drawRadialGradient(
                gradient,
                startCenter: CGPoint(x: cx - dotRadius * 0.3, y: cy + dotRadius * 0.3),
                startRadius: 0,
                endCenter: CGPoint(x: cx, y: cy),
                endRadius: dotRadius,
                options: .drawsAfterEndLocation
            )
        }
        ctx.restoreGState()

        let innerRadius = radius * 0.015
        let innerRect = CGRect(
            x: cx - innerRadius, y: cy - innerRadius,
            width: innerRadius * 2, height: innerRadius * 2
        )
        ctx.setFillColor(theme.centerDot.cgColor)
        ctx.fillEllipse(in: innerRect)
    }
}

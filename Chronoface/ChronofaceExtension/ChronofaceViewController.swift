import AppKit

@objc(ChronofaceViewController)
final class ChronofaceViewController: ScreenSaverViewController {

    private var saverView: ChronofaceRendererView?

    override func loadView() {
        let frame = NSScreen.main?.frame ?? NSRect(x: 0, y: 0, width: 1920, height: 1080)
        let isPreview = frame.width < 400
        let view = ChronofaceRendererView(frame: frame, isPreview: isPreview)
        self.saverView = view
        self.view = view
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        saverView?.startAnimation()
    }

    override func viewDidDisappear() {
        super.viewDidDisappear()
        saverView?.stopAnimation()
    }
}
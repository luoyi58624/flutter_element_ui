import Cocoa
import FlutterMacOS
import window_manager

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)
    
//      let toolbar = NSToolbar(identifier: UUID().uuidString)
//          toolbar.displayMode = .labelOnly
//          toolbar.showsBaselineSeparator = false
//          toolbar.allowsUserCustomization = false
//          toolbar.autosavesConfiguration = true
//          toolbar.sizeMode = .small
//
//
//      self.toolbar = toolbar
//        self.toolbarStyle = .unified
//        self.titleVisibility = .hidden
//        self.titlebarAppearsTransparent = true
//        self.styleMask.insert(.fullSizeContentView)


    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }

     override public func order(_ place: NSWindow.OrderingMode, relativeTo otherWin: Int) {
          super.order(place, relativeTo: otherWin)
          hiddenWindowAtLaunch()
      }
}

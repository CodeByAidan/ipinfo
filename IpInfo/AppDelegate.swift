import SwiftUI
import Foundation

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var popOver = NSPopover()
    var version = "1.0.0"
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        
        let menuView = MenuView()
        
        popOver.behavior = .transient
        popOver.animates = true
        popOver.contentSize = NSSize(width: 380, height: 480)
        popOver.contentViewController = NSViewController()
        popOver.contentViewController?.view = NSHostingView(rootView: menuView)
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        guard let logo = NSImage(named: "menu-bar") else {
            print("Error: menu-bar image not found")
            return
        }
        
        if let MenuButton = statusItem?.button {
            MenuButton.action = #selector(openMenu)
            MenuButton.image = logo
        }
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }
    
    func quitApp() {
        exit(0)
    }
    
    @objc func openMenu() {
        if let menuButton = statusItem?.button {
            self.popOver.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: NSRectEdge.minY)
        }
    }
}

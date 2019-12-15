//
//  Home.swift
//  Sail MacOS
//
//  Created by Erik Bean on 9/20/19.
//  Copyright © 2019 Brick Water Studios. All rights reserved.
//

import Cocoa
import JulieanneSDK
import SailKit

class Home: NSViewController {
    
    @IBOutlet weak var localTitle: NSTextField!
    @IBOutlet weak var backgroundBox: NSBox!
    var HuD: SKHuD!
    @IBOutlet weak var scribe: ScribeBar!
    var settings: SKView!
    var initialized = false
    let scrollView = NSScrollView()
    let tableView = NSTableView()
    
    override func viewDidLayout() {
        if !initialized {
            initialized = true
            DispatchQueue.main.async {
//                self.setupView()
                self.setupTableView()
                self.scrollView.scroll(NSPoint(x: 0, y: self.tableView.frame.height))
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.window?.delegate = self
        HuD = SKHuD(frame: NSRect(x: 8, y: 8, width: 145, height: 145))
        HuD.delegate = self
        view.addSubview(HuD)
        
        let view = NSView(frame: NSRect(origin: backgroundBox.frame.origin, size: CGSize(width: 10, height: 10)))
        view.wantsLayer = true
        view.layer?.backgroundColor = .black
        backgroundBox.addSubview(view)
        
        let v2 = NSView(frame: NSRect(x: 0, y: 0, width: 10, height: 10))
        v2.wantsLayer = true
        v2.layer?.backgroundColor = .white
        backgroundBox.addSubview(v2)
        
        if let i = NSNib.on(owner: self, name: "ScribeBar", bundle: nil) as? ScribeBar {
            scribe = i
            let rect = NSRect(x: 8, y: 8, width: self.backgroundBox.frame.width - 16, height: i.frame.height)
            print(i.frame.height)
            scribe.frame = rect
            scribe.settingsDelegate = self
            backgroundBox.addSubview(scribe)
            NSLayoutConstraint(item: scribe!, attribute: .leading, relatedBy: .equal, toItem: backgroundBox, attribute: .leading, multiplier: 1.0, constant: 8).isActive = true
            NSLayoutConstraint(item: scribe!, attribute: .trailing, relatedBy: .equal, toItem: backgroundBox, attribute: .trailing, multiplier: 1.0, constant: -8).isActive = true
            NSLayoutConstraint(item: scribe!, attribute: .bottom, relatedBy: .equal, toItem: backgroundBox, attribute: .bottom, multiplier: 1.0, constant: -8).isActive = true
            NSLayoutConstraint(item: scribe!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: scribe!.frame.height).isActive = true
        } else {
            print("ScribeBar not found")
        }
        
//        if let j = NSNib.on(owner: self, name: "Settings", bundle: nil) as? SKView {
//            settings = j
//            let rect = NSRect(x: scribe.frame.maxX - 54, y: scribe.frame.midY, width: 54, height: 0)
//            settings.frame = rect
//            self.view.addSubview(settings, positioned: .below, relativeTo: scribe)
//        } else {
//            fatalError("Settings View not found")
//        }
    }
}

extension Home: NSWindowDelegate {
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApplication.shared.terminate(self)
        return true
    }
}

extension Home: SKHuDDelegate {
    func didClickFriends() {
        
    }
    
    func didClickServers() {
        
    }
    
    func didClickWall() {
        
    }
    
    
}

extension Home: SettingsDelegate {
    func openSettings(completion: @escaping () -> Void) {
        NSAnimationContext.runAnimationGroup({ context in
            settings.animator().frame = NSRect(x: scribe.frame.maxX - 54, y: scribe.frame.midY, width: 54, height: scribe.frame.height/2 + 61)
        }, completionHandler: completion)
    }
    
    func closeSettings(completion: @escaping () -> Void) {
        NSAnimationContext.runAnimationGroup({ context in
            settings.animator().frame = NSRect(x: scribe.frame.maxX - 54, y: scribe.frame.midY, width: 54, height: 0)
        }, completionHandler: completion)
    }
}

extension Home: NSTableViewDelegate, NSTableViewDataSource {
    public static let kID = NSUserInterfaceItemIdentifier(rawValue: "CellView")
    
    func setupView() {
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.backgroundBox!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200))
    }
    
    func setupTableView() {
        self.backgroundBox.addSubview(scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .left, relatedBy: .equal, toItem: self.backgroundBox, attribute: .left, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .top, relatedBy: .equal, toItem: self.backgroundBox, attribute: .top, multiplier: 1.0, constant: 23))
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .right, relatedBy: .equal, toItem: self.backgroundBox, attribute: .right, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .bottom, relatedBy: .equal, toItem: self.backgroundBox, attribute: .bottom, multiplier: 1.0, constant: 0 - self.scribe.frame.height - 16))
        tableView.frame = scrollView.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.headerView = nil
        scrollView.backgroundColor = NSColor.clear
        scrollView.drawsBackground = false
        tableView.backgroundColor = NSColor.clear
        tableView.appearance = NSAppearance(named: NSAppearance.Name.vibrantDark)
        tableView.register(NSNib(nibNamed: "SKTableCellMiniView", bundle: nil), forIdentifier: Home.kID)
        tableView.usesAutomaticRowHeights = true
        tableView.rowHeight = 42

        let col = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "col"))
        col.minWidth = 200
        tableView.addTableColumn(col)
        
        scrollView.documentView = tableView
        scrollView.hasHorizontalScroller = false
        scrollView.hasVerticalScroller = true
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 30
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var message = SKMessage(user: "Wookiee Daddy", message: "Hello World, my name is Wookiee Daddy and I will rule you with my hairy fist!")
        message.image = NSImage(named: "Avi")
        
        guard let cell = tableView.makeView(withIdentifier: Home.kID, owner: self) as? SKTableCellMiniView else { fatalError() }
        cell.background.fillColor = .clear
        cell.message = message
        return cell
    }
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        let rowView = NSTableRowView()
        rowView.isEmphasized = false
        return rowView
    }
}

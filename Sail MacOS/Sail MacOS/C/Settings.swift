//
//  Settings.swift
//  Sail MacOS
//
//  Created by Erik Bean on 12/8/19.
//  Copyright © 2019 Brick Water Studios. All rights reserved.
//

import SailKit
import JulieanneSDK
import Cocoa

class Settings: SKView {
    @IBOutlet private weak var box: NSBox!
    @IBOutlet private weak var logout: NSButton!
    
    public var delegate: SettingsDelegate?
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        box.borderColor = SKColor(9, 251, 211, 1)
        box.fillColor = SKColor(9, 251, 211, 1)
        layer?.backgroundColor = SKColor(130,130,130,0.25).cgColor
        layer?.cornerRadius = frame.width / 2
        layer?.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        logout.image?.isTemplate = true
        logout.contentTintColor = SKColor(9, 251, 211, 1)
    }
    
    @IBAction private func didPressLogout(_ sender: NSButton) {
        JAUser.current.logout { success in
            if success.didSucceed {
                let s = NSStoryboard(name: "Login", bundle: .main).instantiateInitialController() as! NSWindowController
                s.showWindow(self)
                window?.close()
            } else if let error = success.error {
                print(error.localizedDescription)
            }
        }
    }
}

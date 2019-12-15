//
//  MultiPass.swift
//  Sail MacOS
//
//  Created by Erik Bean on 11/16/19.
//  Copyright © 2019 Brick Water Studios. All rights reserved.
//

import Cocoa

class MultiPass: NSView {
    
    @IBOutlet private weak var hangup: NSImageView!
    @IBOutlet private weak var title: NSTextField!

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    @IBAction public func hangup(_ sender: Any) {
        
    }
    
}

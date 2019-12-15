//
//  SKHuDButton.swift
//  Sail MacOS
//
//  Created by Erik Bean on 12/5/19.
//  Copyright © 2019 Brick Water Studios. All rights reserved.
//

import Cocoa

class SKHuDButton: NSButton {
    
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        wantsLayer = true
        bezelColor = .clear
        bezelStyle = .shadowlessSquare
        isBordered = false
    }
    
    func setupImage(_ size: NSSize, color: NSColor? = nil) {
        image?.size = size
        if color != nil {
            contentTintColor = color
            image?.isTemplate = true
        }
    }
    
    func setupLayer(backgroundColor color: CGColor, borderColor: CGColor? = nil) {
        if let color = borderColor {
            layer?.borderWidth = 3
            layer?.borderColor = color
        }
        layer?.cornerRadius = frame.height / 2
        layer?.backgroundColor = color
    }
}

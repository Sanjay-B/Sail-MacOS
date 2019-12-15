//
//  Constraint+Helper.swift
//  Chat Sample
//
//  Created by Erik Bean on 10/31/19.
//  Copyright © 2019 Brick Water Studios. All rights reserved.
//

import Cocoa


extension NSView {
    @objc func prepareForConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        wantsLayer = true
        layer!.cornerRadius = frame.height / 2
        layer!.masksToBounds = true
    }
    
    func addSubviews(_ views: [NSView]) {
        for view in views {
            self.addSubview(view)
        }
    }
    
    var color: NSColor? {
        get {
            guard let color = layer?.backgroundColor else { return nil }
            return NSColor(cgColor: color)
        }
        set {
            wantsLayer = true
            layer?.backgroundColor = newValue?.cgColor
        }
    }
}

extension NSBox {
    func set(_ color: NSColor) {
        fillColor = color
        borderColor = color
    }
    
//    override func prepareForConstraints() {
//        super .prepareForConstraints()
//        boxType = .custom
//        borderType = .grooveBorder
//        titlePosition = .noTitle
//    }
}

extension NSAttributedString {
    static var space: NSAttributedString {
        return NSAttributedString(string: " ")
    }
    
    static var colon: NSAttributedString {
        return NSAttributedString(string: ":")
    }
}

extension DateFormatter {
    func attributedString(from date: Date) -> NSAttributedString {
        return NSAttributedString(string: self.string(from: date))
    }
    
    func mutableAttributedString(from date: Date) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self.string(from: date))
    }
    
    convenience init(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, locale: Locale = Locale.current) {
        self.init()
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
        self.locale = locale
    }
}

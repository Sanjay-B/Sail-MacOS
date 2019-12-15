//
//  SKTableCellMiniView.swift
//  Chat Sample
//
//  Created by Erik Bean on 11/12/19.
//  Copyright © 2019 Brick Water Studios. All rights reserved.
//

import Cocoa
import SailKit

class SKTableCellMiniView: NSTableCellView {
    
    @IBOutlet weak var avatar: NSImageView!
    @IBOutlet weak var dateStamp: NSTextField!
    @IBOutlet weak var messageText: NSTextField!
    @IBOutlet weak var background: NSBox!
    
    public var message: SKMessage {
        get { return _message }
        set {
            self._message = newValue
            self.avatar.image = newValue.image
            let df = DateFormatter(dateStyle: .none, timeStyle: .short)
            let i = NSMutableAttributedString()
            if newValue.isEdited {
                i.append(NSAttributedString(string: "Edited On: "))
                i.append(df.attributedString(from: newValue.editedOn))
            } else {
                i.append(df.attributedString(from: newValue.createdOn))
            }
            i.append(.space)
            i.append(newValue.username)
            i.append(.colon)
            self.dateStamp.attributedStringValue = i
            self.messageText.attributedStringValue = newValue.message!
        }
    }
    private var _message: SKMessage!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        layer?.backgroundColor = .clear
        avatar.prepareForConstraints()
    }
}

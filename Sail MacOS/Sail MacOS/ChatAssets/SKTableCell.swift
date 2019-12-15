//
//  SKTableCell.swift
//  Chat Sample
//
//  Created by Erik Bean on 10/31/19.
//  Copyright © 2019 Brick Water Studios. All rights reserved.
//

import SailKit
import Cocoa

class SampleCell: NSTableCellView {
    private var topBox: NSBox {
        let i = NSBox()
        i.set(SKColor.lightTextColor)
        i.prepareForConstraints()
        return i
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        addSubview(topBox)
        let tbConstraints = [
            topBox.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            topBox.heightAnchor.constraint(equalToConstant: 2),
            topBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            topBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(tbConstraints)
    }

    required init?(coder: NSCoder) { super.init(coder: coder) }
}



class SKTableCell: NSTableCellView {

    // MARK: Local Variables
    private var isDetailVisable = false
    private var isEdited = false

    // MARK: Objects

    public var username: NSTextField {
        let i = NSTextField()
        i.isEditable = false
        i.isBordered = false
        i.backgroundColor = .clear
        i.font = NSFont.boldSystemFont(ofSize: 13)
        // TODO: >> Custimize Username Text if needed
        return i
    }

    private var topBox: NSBox {
        let i = NSBox()
        i.set(SKColor.lightTextColor)
        i.prepareForConstraints()
        return i
    }

    private var middleBox: NSBox {
        let i = NSBox()
        i.set(SKColor.lightTextColor)
        i.prepareForConstraints()
        return i
    }

    private var bottomBox: NSBox {
        let i = NSBox()
        i.set(SKColor.lightTextColor)
        i.prepareForConstraints()
        return i
    }

    public var avatar: NSImageView {
        let i = NSImageView()
        i.prepareForConstraints()
        i.layer?.cornerRadius = 25
        return i
    }

// Can become lazy
    private var advancedText: NSTextField {
        let i = NSTextField()
        i.isEditable = false
        i.isBordered = false
        i.backgroundColor = .clear
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        df.locale = Locale.current
        i.stringValue = "sent on: " + df.string(from: Date())
        if isEdited {
            i.stringValue.append(" || last edited: \(df.string(from: Date()))")
        }
        // TODO: >> Needs Updated
        return i
    }

    private lazy var textView: NSTextField = {
        let i = NSTextField()
        //TODO: >> Custimize textfield
        return i
    }()
//
//    private lazy var photoView: NSImageView = {
//        let i = NSImageView()
//        //TODO: >> Custimize imagefield
//        return i
//    }()

    private var stack: NSStackView {
        let i = NSStackView()
        i.addArrangedSubview(middleBox)
        i.addArrangedSubview(username)
//        i.addArrangedSubview(advancedText)
        i.prepareForConstraints()
        i.orientation = .vertical
        i.spacing = 5
        i.alignment = .leading
        return i
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        print(#function + " was called")
        superview?.addSubview(topBox)
//        super.addSubview(topBox)
        self.addSubviews([/*topBox,*/ bottomBox, avatar, stack])
        let click = NSClickGestureRecognizer(target: self, action: #selector(didClick(_:)))
        addGestureRecognizer(click)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(#function + " was called")
        addSubviews([topBox, bottomBox, avatar, stack])
        let click = NSClickGestureRecognizer(target: self, action: #selector(didClick(_:)))
        addGestureRecognizer(click)
    }

    override func updateConstraints() {
        super.updateConstraints()

        print("--------------------------")
        print("DEBUG LOG for All Objects")
        print("Super: " + super.debugDescription)
        print("Super Top Anchor: " + super.topAnchor.debugDescription)
        print("Super View: " + superview.debugDescription)
        print("Username: " + username.debugDescription)
        print("Top Box: " + topBox.debugDescription)
        print("Top Box Top Anchor: " + topBox.topAnchor.debugDescription)
        print("Middle Box: " + middleBox.debugDescription)
        print("Bottom Box: " + bottomBox.debugDescription)
        print("Avatar: " + avatar.debugDescription)
        print("Advanced Text: " + advancedText.debugDescription)
        print("Stack: " + stack.debugDescription)
        print("END DEBUG")
        print("--------------------------")

        guard let sView = superview else { fatalError() }

        let tbConstraints = [
            topBox.topAnchor.constraint(equalTo: sView.topAnchor, constant: 8),
            topBox.heightAnchor.constraint(equalToConstant: 2),
            topBox.leadingAnchor.constraint(equalTo: sView.leadingAnchor, constant: 16),
            topBox.trailingAnchor.constraint(equalTo: sView.trailingAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(tbConstraints)

//        print("--------------------------")
//        print("DEBUG LOG for Super\n")
//        print(super.debugDescription + "\n")
//        print("Subview List for Super\n")
//        for i in super.subviews {
//            print(i.debugDescription)
//        }
//        print("END DEBUG")
//        print("--------------------------")

//        topBox.topAnchor.constraint(equalTo: super.topAnchor, constant: 8).isActive = true
//        super.topAnchor.constraint(equalTo: topBox.topAnchor, constant: 8).isActive = true
//        sView.topAnchor.constraint(equalTo: topBox.topAnchor, constant: 8).isActive = true
//        topBox.topAnchor.constraint(equalTo: sView.topAnchor, constant: 8).isActive = true
//        topBox.heightAnchor.constraint(equalToConstant: 2).isActive = true
//        topBox.leadingAnchor.constraint(equalTo: sView.leadingAnchor , constant: 16).isActive = true
//        topBox.trailingAnchor.constraint(equalTo: sView.trailingAnchor, constant: -16).isActive = true

        //bottomBox.bottomAnchor.constraint(equalTo: sView.bottomAnchor, constant: -8).isActive = true
        //bottomBox.heightAnchor.constraint(equalToConstant: 2).isActive = true
        //bottomBox.leadingAnchor.constraint(equalTo: sView.leadingAnchor, constant: 16).isActive = true
        //bottomBox.trailingAnchor.constraint(equalTo: sView.trailingAnchor, constant: -16).isActive = true

        //avatar.widthAnchor.constraint(equalToConstant: 50).isActive = true
        //avatar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //avatar.leadingAnchor.constraint(equalTo: sView.leadingAnchor, constant: 8).isActive = true
        //avatar.bottomAnchor.constraint(equalTo: bottomBox.topAnchor, constant: -8).isActive = true

        //stack.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 8).isActive = true
        //stack.bottomAnchor.constraint(equalTo: bottomBox.topAnchor, constant: -8).isActive = true
        //stack.trailingAnchor.constraint(equalTo: sView.trailingAnchor, constant: 8).isActive = true

        //middleBox.heightAnchor.constraint(equalToConstant: 2).isActive = true
        //middleBox.widthAnchor.constraint(equalToConstant: username.frame.width).isActive = true
    }

    @objc func didClick(_ sender: Any) {
        if isDetailVisable {
            isDetailVisable.toggle()
            stack.removeArrangedSubview(advancedText)
        } else {
            isDetailVisable.toggle()
            stack.addArrangedSubview(advancedText)
        }
        stack.needsUpdateConstraints = true
        updateConstraints()
    }

    func set(_ message: SKMessage) {
        guard let j = message.message else {
            fatalError("Only text messages are supported at this time")
        }
        let i = textView
        i.attributedStringValue = j
        stack.addArrangedSubview(i)
    }
}

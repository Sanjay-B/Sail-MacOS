//
//  SKScribeBar.swift
//  Sail MacOS
//
//  Created by Erik Bean on 12/8/19.
//  Copyright © 2019 Brick Water Studios. All rights reserved.
//

import Cocoa
import SailKit
import JulieanneSDK

class ScribeBar: NSView {
    @IBOutlet private weak var send: NSButton!
    @IBOutlet private weak var file: NSButton!
    @IBOutlet private weak var photo: NSButton!
    @IBOutlet private weak var settings: NSButton!
    @IBOutlet private weak var scribe: NSTextField!
    @IBOutlet private weak var marker: NSBox!
    
    public var delegate: ScribeDelegate?
    public var settingsDelegate: SettingsDelegate?
    
    private lazy var settingsMenu: SKView = {
        let view = SKView(frame: CGRect(x: frame.maxX - 30, y: frame.maxY, width: 30, height: 30))
        view.wantsLayer = true
        view.layer?.cornerRadius = view.frame.width/2
        return view
    }()
    
    private var tint: SKColor = SKColor(9, 251, 211, 1)
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Update draw here
        wantsLayer = true
        translatesAutoresizingMaskIntoConstraints = false
        layer?.cornerRadius = dirtyRect.height/2
        layer?.borderWidth = 3
        layer?.borderColor = tint.cgColor
        layer?.backgroundColor = SKColor(130,130,130,0.25).cgColor
        
        send.image?.isTemplate = true
        send.contentTintColor = tint
        
        photo.image?.isTemplate = true
        photo.contentTintColor = tint
        
        file.image?.isTemplate = true
        file.contentTintColor = tint
        
        marker.borderColor = tint
        marker.fillColor = tint
        
        settings.image?.isTemplate = true
        settings.contentTintColor = tint
    }
    
    public func changeState(to state: ScribeState, isAnimated: Bool = true) {
        switch state {
        case .static:
            if isAnimated {
                NSAnimationContext.runAnimationGroup { context in
                    context.duration = 2.5
                    let rect = NSRect(x: frame.maxX - (settings.frame.width + 16), y: frame.minY, width: settings.frame.width + 16, height: frame.height)
                    animator().frame = rect
                }
            }
        case .search:
            break
        case .message:
            break
        case .default:
            break
        }
    }
    
    /// Change the state of the Scribe Bar without animating it
    public func setState(to state: ScribeState) {
        changeState(to: state, isAnimated: false)
    }
    
    @IBAction private func didPressSend(_ sender: Any) {
        
    }
    
    @IBAction private func didPressPhoto(_ sender: NSButton) {
        
    }
    
    @IBAction private func didPressFile(_ sender: NSButton) {
        
    }
    
    private var isSettingsOpen = false
    @IBAction private func didPressSettings(_ sender: NSButton) {
        if isSettingsOpen {
            settingsDelegate?.closeSettings { self.isSettingsOpen.toggle() }
        } else {
            settingsDelegate?.openSettings { self.isSettingsOpen.toggle() }
        }
    }
}

protocol ScribeDelegate: class {
    func didSend(with: SKMessage)
}

protocol SettingsDelegate: class {
    func openSettings(completion: @escaping () -> Void)
    func closeSettings(completion: @escaping () -> Void)
}

public enum ScribeState {
    case search
    case message
    case `default`
    case `static`
}

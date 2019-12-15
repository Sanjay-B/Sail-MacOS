//
//  SKHuD.swift
//  Sail MacOS
//
//  Created by Erik Bean on 12/5/19.
//  Copyright © 2019 Brick Water Studios. All rights reserved.
//

import Cocoa
import SailKit

public final class SKHuD: SKView {
    
    public var delegate: SKHuDDelegate?
    public var theme: SKHuDTheme = SKHuDTheme()
    
    private var button: NSButton!
    
    private lazy var friends: NSButton = {
        let i = NSButton(image: NSImage(named: "friends.png")!, target: self, action: #selector(didClickFriends(_:)))
        i.frame = NSRect(origin: button.frame.origin, size: CGSize(width: 45, height: 45))
        i.wantsLayer = true
        i.bezelColor = .clear
        i.bezelStyle = .shadowlessSquare
        i.isBordered = false
        i.image?.size = NSSize(width: 25, height: 25)
        i.image?.isTemplate = true
        i.contentTintColor = theme.secondaryButtonMainColor
        i.layer?.backgroundColor = theme.backgroundColor.cgColor
        i.layer?.cornerRadius = i.frame.height / 2
        i.layer?.borderWidth = 3
        i.layer?.borderColor = SKColor(9, 251, 211, 1).cgColor
        return i
    }()
    
    private lazy var servers: NSButton = {
        let i = NSButton(image: NSImage(named: "home.png")!, target: self, action: #selector(didClickServers(_:)))
        i.frame = NSRect(origin: button.frame.origin, size: CGSize(width: 45, height: 45))
        i.wantsLayer = true
        i.bezelColor = .clear
        i.bezelStyle = .shadowlessSquare
        i.isBordered = false
        i.image?.size = NSSize(width: 25, height: 25)
        i.image?.isTemplate = true
        i.contentTintColor = theme.secondaryButtonMainColor
        i.layer?.backgroundColor = theme.backgroundColor.cgColor
        i.layer?.cornerRadius = i.frame.height / 2
        i.layer?.borderWidth = 3
        i.layer?.borderColor = theme.secondaryButtonBorderColor.cgColor
        return i
    }()
    
    private lazy var wall: NSButton = {
        let i = NSButton(image: NSImage(named: "wall.png")!, target: self, action: #selector(didClickWall(_:)))
        i.frame = NSRect(origin: button.frame.origin, size: CGSize(width: 45, height: 45))
        i.wantsLayer = true
        i.bezelColor = .clear
        i.bezelStyle = .shadowlessSquare
        i.isBordered = false
        i.image?.size = NSSize(width: 25, height: 25)
        i.image?.isTemplate = true
        i.contentTintColor = theme.secondaryButtonMainColor
        i.layer?.backgroundColor = theme.backgroundColor.cgColor
        i.layer?.cornerRadius = i.frame.height / 2
        i.layer?.borderWidth = 3
        i.layer?.borderColor = theme.secondaryButtonBorderColor.cgColor
        return i
    }()
    
    override public func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        wantsLayer = true
        button = NSButton(image: NSImage(named: "7655.png")!, target: self, action: #selector(didPressMenu(_:)))
        button.frame = NSRect(x: 4, y: 4, width: 45, height: 45)
        button.wantsLayer = true
        button.bezelColor = .clear
        button.bezelStyle = .shadowlessSquare
        button.image?.size = NSSize(width: 60, height: 60)
        button.layer?.backgroundColor = theme.mainButtonColor.cgColor
        button.layer?.cornerRadius = 25
        addSubview(button)
        self.addSubview(self.friends, positioned: .below, relativeTo: self.button)
        self.addSubview(self.servers, positioned: .below, relativeTo: self.button)
        self.addSubview(self.wall, positioned: .below, relativeTo: self.button)
        drawBackground()
    }
    
    public private(set) var isMenuShown = false
    @objc private func didPressMenu(_ sender: NSClickGestureRecognizer) {
        if !isMenuShown {
            isMenuShown = true
            if let layer = layer as? CAShapeLayer {
                let fx = self.frame.height - 20 - self.button.frame.height
                let fy = self.frame.minX + 6
                let sx = self.frame.height / 2.7
                let sy  = self.frame.width / 2.7
                let wx = fy
                let wy = fx
                NSAnimationContext.runAnimationGroup { context in
                    context.duration = 1.0
                    layer.strokeEnd = 1.0
                    layer.strokeColor = theme.borderColor.cgColor
                    layer.fillColor = theme.backgroundColor.cgColor
                    self.friends.animator().frame.origin = NSPoint(x: fx, y: fy)
                    self.servers.animator().frame.origin = NSPoint(x: sx, y: sy)
                    self.wall.animator().frame.origin = NSPoint(x: wx, y: wy)
                }
            } else {
                print("Could not find layer")
            }
        } else {
            isMenuShown = false
            if let layer = layer as? CAShapeLayer {
                NSAnimationContext.runAnimationGroup { context in
                    context.duration = 1.0
                    self.friends.animator().frame.origin = self.button.frame.origin
                    self.servers.animator().frame.origin = self.button.frame.origin
                    self.wall.animator().frame.origin = self.button.frame.origin
                    layer.strokeColor = theme.backgroundColor.cgColor
                    layer.fillColor = .clear
                    layer.strokeEnd = 0.0
                }
            } else {
                print("Could not find layer")
            }
        }
    }
    
    private func drawBackground() {
        let path = NSBezierPath()
        path.move(to: NSPoint(x: button.frame.midX, y: 4))
        path.appendArc(from: frame.origin,
                       to: NSPoint(x: 4, y: button.frame.midY),
                       radius: button.layer!.cornerRadius)
        path.line(to: NSPoint(x: 4, y: frame.height - 4))
        path.appendArc(withCenter: button.frame.origin,
                       radius: frame.height - 8,
                       startAngle: 90,
                       endAngle: 0,
                       clockwise: true)
        path.close()
        let drawLayer = CAShapeLayer()
        drawLayer.path = path.cgPath
        drawLayer.strokeColor = theme.backgroundColor.cgColor
        drawLayer.lineWidth = 3
        drawLayer.strokeEnd = 0.0
        drawLayer.fillColor = .clear
        layer = drawLayer
        layerContentsRedrawPolicy = .onSetNeedsDisplay
    }
    
    @objc private func didClickFriends(_ sender: NSClickGestureRecognizer) {
        guard let delegate = delegate else { fatalError("SKHuDDelegate may not be nil") }
        delegate.didClickFriends()
        isMenuShown = false
        if let layer = layer as? CAShapeLayer {
            NSAnimationContext.runAnimationGroup { context in
                context.duration = 1.5
                self.friends.animator().frame.origin = self.button.frame.origin
                self.servers.animator().frame.origin = self.button.frame.origin
                self.wall.animator().frame.origin = self.button.frame.origin
                layer.strokeColor = theme.backgroundColor.cgColor
                layer.fillColor = .clear
                layer.strokeEnd = 0.0
            }
        } else {
            print("Could not find layer")
        }
    }
    
    @objc private func didClickServers(_ sender: NSClickGestureRecognizer) {
        guard let delegate = delegate else { fatalError("SKHuDDelegate must not be nil") }
        delegate.didClickServers()
        isMenuShown = false
        if let layer = layer as? CAShapeLayer {
            NSAnimationContext.runAnimationGroup { context in
                context.duration = 1.5
                self.friends.animator().frame.origin = self.button.frame.origin
                self.servers.animator().frame.origin = self.button.frame.origin
                self.wall.animator().frame.origin = self.button.frame.origin
                layer.strokeColor = theme.backgroundColor.cgColor
                layer.fillColor = .clear
                layer.strokeEnd = 0.0
            }
        } else {
            print("Could not find layer")
        }
    }
    
    @objc private func didClickWall(_ sender: NSClickGestureRecognizer) {
        guard let delegate = delegate else { fatalError("SKHuDDelegate must not be nil") }
        delegate.didClickWall()
        isMenuShown = false
        if let layer = layer as? CAShapeLayer {
            NSAnimationContext.runAnimationGroup { context in
                context.duration = 1.5
                self.friends.animator().frame.origin = self.button.frame.origin
                self.servers.animator().frame.origin = self.button.frame.origin
                self.wall.animator().frame.origin = self.button.frame.origin
                layer.strokeColor = theme.backgroundColor.cgColor
                layer.fillColor = .clear
                layer.strokeEnd = 0.0
            }
        } else {
            print("Could not find layer")
        }
    }
}

public protocol SKHuDDelegate: class {
    func didClickFriends()
    func didClickServers()
    func didClickWall()
}

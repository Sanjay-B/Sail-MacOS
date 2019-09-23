//
//  ViewController.swift
//  Sail MacOS
//
//  Created by Erik Bean on 9/11/19.
//  Copyright © 2019 Brick Water Studios. All rights reserved.
//

import Cocoa
import JulieanneSDK

class Login: NSViewController {

    @IBOutlet weak var username: NSTextField!
    @IBOutlet weak var password: NSTextField!
    @IBOutlet weak var backgroundImage: NSImageView!
    @IBOutlet weak var error: NSTextField!

    @IBAction func didPressLogin(_ sender: NSButton) {
        print("didPressLoging")
        JAUser.current.login(username: username.stringValue, password: password.stringValue) { success in
            if !success.didSucceed {
                if success.error != nil {
                    error(success.error!.localizedDescription)
                } else {
                    error("There was an unknown error, please try again later")
                }
            } else {
                hideError()
                let s = NSStoryboard(name: "Main", bundle: .main).instantiateInitialController() as! NSWindowController
                s.showWindow(self)
                self.view.window?.close()
            }
        }
    }

    @IBAction func didPressForget(_ sender: NSButton) {
        hideError()
        // Account Recovery via Julieanne SDK
    }
    
    @IBAction func releaseFirstResponder(_ sender: NSGestureRecognizer) {
        view.window?.endEditing(for: self)
    }

    private func error(_ message: String) {
        error.stringValue = message
        error.isHidden = false
    }
    
    private func hideError() { error.isHidden = true }
}


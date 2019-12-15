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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.window?.delegate = self
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.wantsLayer = true
        backgroundImage.layer?.contentsGravity = .resizeAspectFill
        print("---")
        print(ipAddress())
        print("---")
    }
    
    private func getIFAddresses() -> [String] {
        var addresses = [String]()
     
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return [] }
        guard let firstAddr = ifaddr else { return [] }
     
        // For each interface ...
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let flags = Int32(ptr.pointee.ifa_flags)
            let addr = ptr.pointee.ifa_addr.pointee
     
            // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
            if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
     
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    if (getnameinfo(ptr.pointee.ifa_addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                        let address = String(cString: hostname)
                        addresses.append(address)
                    }
                }
            }
        }
     
        freeifaddrs(ifaddr)
        return addresses
    }
    
    private func ipAddress() -> String {
        let i = getIFAddresses()
        for j in i {
            if j.rangeOfCharacter(from: CharacterSet.letters) == nil {
                return j
            }
        }
        return "unknown"
    }

    @IBAction func didPressLogin(_ sender: NSButton) {
        print(#function)
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

extension Login: NSWindowDelegate {
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApplication.shared.terminate(self)
        return true
    }
}

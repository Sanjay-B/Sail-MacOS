//
//  Home.swift
//  Sail MacOS
//
//  Created by Erik Bean on 9/20/19.
//  Copyright © 2019 Brick Water Studios. All rights reserved.
//

import Cocoa
import JulieanneSDK

class Home: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func logout(_ sender: NSButton) {
        JAUser.current.logout { success in
            if success.didSucceed {
                let s = NSStoryboard(name: "Login", bundle: .main).instantiateInitialController() as! NSWindowController
                s.showWindow(self)
                self.view.window?.close()
            } else if let error = success.error {
                print(error.localizedDescription)
            }
        }
    }
}

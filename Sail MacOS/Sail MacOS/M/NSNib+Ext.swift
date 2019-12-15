//
//  NSNib+Ext.swift
//  Sail MacOS
//
//  Created by Erik Bean on 12/8/19.
//  Copyright © 2019 Brick Water Studios. All rights reserved.
//

import Cocoa

public extension NSNib {
    
    static func on(owner: Any?, name nibName: String, bundle: Bundle?) -> AnyObject? {
        let n = NSNib(nibNamed: nibName, bundle: bundle)
        var arr: NSArray?
        n?.instantiate(withOwner: owner, topLevelObjects: &arr)
        if let arr = arr {
            for i in arr {
                if i is NSApplication {
                    continue
                } else {
                    return i as AnyObject
                }
            }
        }
        return nil
    }
    
}

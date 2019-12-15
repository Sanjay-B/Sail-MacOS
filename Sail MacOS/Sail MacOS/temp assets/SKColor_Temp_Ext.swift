//
//  SKColor_Temp_Ext.swift
//  Sail MacOS
//
//  Created by Erik Bean on 12/8/19.
//  Copyright © 2019 Brick Water Studios. All rights reserved.
//

import SailKit
import AppKit

extension SKColor {
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}

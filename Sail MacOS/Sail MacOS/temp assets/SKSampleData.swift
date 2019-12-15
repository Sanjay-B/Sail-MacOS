//
//  SKSampleData.swift
//  Sail MacOS
//
//  Created by Erik Bean on 12/10/19.
//  Copyright © 2019 Brick Water Studios. All rights reserved.
//


import AVFoundation

class SKSampleData {
    static let video = AVAsset(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video", ofType: "mp4")!))
    static let audio = AVAsset(url: URL(fileURLWithPath: Bundle.main.path(forResource: "audio", ofType: "mp3")!))
}

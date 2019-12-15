//
//  JAServer.swift
//  Sail MacOS
//
//  Created by Erik Bean on 12/13/19.
//  Copyright © 2019 Brick Water Studios. All rights reserved.
//

import Foundation

public class CodableServer: Codable {
    
    public var token: String
    public var id: UUID
    public var name: String
    public var banner: URL?
    public var status: Int
    public var enhancements: [CodableObject]?
    public var userList: [CodableMiniUser]
    public var blockList: [CodableMiniUser]
    public var openingChannel: UUID
    public var channelList: [CodableChannel]
    
    /// Create an empty server for test reasons only
    ///
    /// - Warning: This will create a test server with nobody in it. There will be no way to access the server once created unless you manually add yourself tot it. This is only for testing purposes
    public init() { token = ""; id = UUID(); name = ""; banner = nil; status = 0; enhancements = nil; userList = []; blockList = []; openingChannel = UUID(); channelList = [] }
    
    /// Load a server with local test data from the test file `SailDevTestServer.txt`
    ///
    /// - Warning: If the local file is missing, edited, or corrupt, the server will not load
    @available(OSX 10.9, *)
    static public func testServer() throws -> CodableServer {
        if let url = Bundle.main.url(forResource: "SailDevTestServer", withExtension: "txt") {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(CodableServer.self, from: data)
        } else {
            throw NSError(domain: "com.bws.testError", code: 400, userInfo: [NSLocalizedDescriptionKey: "Could not find test server data"])
        }
    }
}

public class CodableMiniUser: Codable {
    public var id: UUID
    public var username: String
    public var avatar: URL?
    public var status: Int
}

public class CodableUser: Codable {
    public var id: UUID
    public var username: String
    public var avatar: URL?
    public var status: Int
    public var serverList: [CodableServer]
    public var blockList: [CodableMiniUser]
    public var friendsList: [CodableMiniUser]
    public var messages: [CodableDirectMessage]
}

public class CodableObject: Codable {
    public var id: UUID
    public var frame: NSRect
    public var image: URL?
}

public class CodableDirectMessage: Codable {
    public var id: UUID
    public var users: [CodableMiniUser]
    public var messages: [CodableMessage]
}

public class CodableMessage: Codable {
    public var id: UUID
    public var username: String
    public var message: String?
    public var image: URL?
    public var type: Int
    public let createdOn: Date
    public var editedOn: Date?
    public var isEdited: Bool
}

public class CodableChannel: Codable {
    public var id: UUID
    public var name: String
    public var type: Int
    public var messages: [CodableMessage]
    public var enhancements: [CodableObject]?
}

//
//  SessionId.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/11/18.
//

import Foundation

struct SessionId {
    let id: String
}

extension SessionId : Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        try id = container.decode(String.self)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(id)
    }
}

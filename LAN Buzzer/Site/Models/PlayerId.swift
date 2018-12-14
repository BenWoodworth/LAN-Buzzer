//
//  PlayerId.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/11/18.
//

import Foundation

struct PlayerId {
    let id: Int
}

extension PlayerId : Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        try id = container.decode(Int.self)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(id)
    }
}

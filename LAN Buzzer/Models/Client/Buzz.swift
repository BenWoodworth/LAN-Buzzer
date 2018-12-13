//
//  Buzz.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/11/18.
//

import Foundation

struct Buzz {
    let playerId: PlayerId
    let offsetMs: Int
}

extension Buzz : Codable {
    
    enum CodingKeys: String, CodingKey {
        case playerId = "player_id"
        case offsetMs = "offset_ms"
    }
}

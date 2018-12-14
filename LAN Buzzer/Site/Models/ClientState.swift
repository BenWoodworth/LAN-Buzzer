//
//  ClientState.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/11/18.
//

import Foundation

struct ClientState {
    let sessionId: SessionId
    let playerId: PlayerId
    let players: [Player]
    let buzzes: [Buzz]
}

extension ClientState {
    
    enum CodingKeys: String, CodingKey {
        case sessionId = "session_id"
        case playerId = "player_id"
        case players = "players"
        case buzzes = "buzzes"
    }
}

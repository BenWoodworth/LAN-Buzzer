//
//  Client.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/11/18.
//

import Foundation

struct PlayerInfo {
    let name: String
    let color: PlayerColor
    
    func copy(
        name: String? = nil,
        color: PlayerColor? = nil
    ) -> PlayerInfo {
        return PlayerInfo(
            name: name ?? self.name,
            color: color ?? self.color
        )
    }
}

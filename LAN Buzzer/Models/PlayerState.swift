//
//  ClientState.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/11/18.
//

import Foundation

struct PlayerState {
    let player: PlayerInfo
    let players: [PlayerInfo]
    let buzzes: [Buzz]
    
    func copy(
        player: PlayerInfo? = nil,
        players: [PlayerInfo]? = nil,
        buzzes: [Buzz]? = nil
    ) -> PlayerState {
        return PlayerState(
            player: player ?? self.player,
            players: players ?? self.players,
            buzzes: buzzes ?? self.buzzes
        )
    }
}

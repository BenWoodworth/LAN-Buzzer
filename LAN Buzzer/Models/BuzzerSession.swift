//
//  BuzzerSession.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/15/18.
//

import Foundation
import MulticastDelegateSwift

private let PHI = 1.6180339887498948

class BuzzerSession : PlayerDelegate, BuzzerDelegate {
    private let buzzer: Buzzer
    
    let delegate = MulticastDelegate<BuzzerSessionDelegate>()
    
    private(set) var players: [Player] = []
    private var nextPlayerNumber = 0
    
    var buzzes: [Buzz] {
        return buzzer.buzzes
    }

    init(buzzer: Buzzer) {
        self.buzzer = buzzer
        buzzer.delegate += self
    }
    
    private func initPlayerInfo(player: Player) {
        var name: String
        var number: Int
        
        repeat {
            number = nextPlayerNumber
            nextPlayerNumber += 1
            
            name = "Player \(number)"
        } while players.contains {
            $0.name == name
        }
        
        player.name = name
        player.color = PlayerColor(
            hue: Double(number) * PHI * 360.0,
            saturation: 1.0,
            value: 1.0
        )
    }
    
    func onPlayerJoin(player: Player) {
        delegate += player
        player.delegate = self
        players.append(player)
        initPlayerInfo(player: player)
        
        delegate.invokeDelegates {
            $0.onBuzzerSessionUpdate(buzzerSession: self)
        }
    }
    
    func onPlayerLeave(player: Player) {
        delegate -= player
        player.delegate = nil
        players = players.filter { $0 !== player }
        
        delegate.invokeDelegates {
            $0.onBuzzerSessionUpdate(buzzerSession: self)
        }
    }
    
    func onPlayerUpdate(player: Player) {
        delegate.invokeDelegates {
            $0.onBuzzerSessionUpdate(buzzerSession: self)
        }
    }
    
    func onPlayerBuzz(player: Player, buzzTime: Date) {
        buzzer.buzz(player: player, buzzTime: buzzTime)
    }
    
    func onBuzzerChange(buzzer: Buzzer) {
        delegate.invokeDelegates {
            $0.onBuzzerSessionUpdate(buzzerSession: self)
        }
    }
}

protocol BuzzerSessionDelegate {
    
    func onBuzzerSessionUpdate(buzzerSession: BuzzerSession)
}

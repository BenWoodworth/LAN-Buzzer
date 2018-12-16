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
    
    private var delegates = MulticastDelegate<BuzzerSessionDelegate>()
    
    private(set) var players: [Player] = []
    private var nextPlayerNumber = 1
    
    var buzzes: [Buzz] {
        return buzzer.buzzes
    }

    init(buzzer: Buzzer) {
        self.buzzer = buzzer
        buzzer.delegate = self
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
            hue: Double(number - 1) * PHI * 360.0,
            saturation: 1.0,
            value: 1.0
        )
    }
    
    func onPlayerJoin(player: Player) {
        delegates += player
        players.append(player)
        initPlayerInfo(player: player)
        
        delegates.invokeDelegates {
            $0.onBuzzerSessionChange(buzzerSession: self)
        }
    }
    
    func onPlayerLeave(player: Player) {
        delegates -= player
        players = players.filter { $0 !== player }
        
        delegates.invokeDelegates {
            $0.onBuzzerSessionChange(buzzerSession: self)
        }
    }
    
    func onPlayerBuzz(player: Player, buzzTime: Date) {
        buzzer.buzz(player: player, buzzTime: buzzTime)
    }
    
    func onBuzzerChange(buzzer: Buzzer) {
        delegates.invokeDelegates {
            $0.onBuzzerSessionChange(buzzerSession: self)
        }
    }
}

protocol BuzzerSessionDelegate {
    
    func onBuzzerSessionChange(buzzerSession: BuzzerSession)
}

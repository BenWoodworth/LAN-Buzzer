//
//  Buzzer.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/14/18.
//

import Foundation
import MulticastDelegateSwift

class Buzzer {
    var resetInterval: TimeInterval
    var delegate = MulticastDelegate<BuzzerDelegate>()
    
    private var playerBuzzTimes = Dictionary<PlayerKey, Date>()
    private var lastBuzz: Date?
    
    private(set) var buzzes: [Buzz] = []
    
    init(resetInterval: TimeInterval) {
        self.resetInterval = resetInterval
    }
    
    func buzz(player: Player, buzzTime: Date) {
        if lastBuzz != nil && buzzTime.timeIntervalSince(lastBuzz!) < resetInterval {
            playerBuzzTimes.removeAll()
            lastBuzz = nil
        }
        
        let playerKey = PlayerKey(player)
        let previousBuzz = playerBuzzTimes[playerKey]
        if previousBuzz == nil || previousBuzz! > buzzTime {
            playerBuzzTimes[playerKey] = buzzTime
            
            if lastBuzz == nil || buzzTime > lastBuzz! {
                lastBuzz = buzzTime
            }
            
            buzzes = getBuzzes()
            
            delegate.invokeDelegates {
                $0.onBuzzerChange(buzzer: self)
            }
        }
    }
    
    private func getBuzzes() -> [Buzz] {
        if playerBuzzTimes.count == 0 {
            return []
        }
        
        let firstBuzz = playerBuzzTimes
            .min { $0.value < $1.value }!
            .value
        
        return playerBuzzTimes
            .map { entry in
                Buzz(
                    player: entry.key.player,
                    offset: entry.value.timeIntervalSince(firstBuzz)
                )
            }
            .sorted { $0.offset < $1.offset }
    }
    
    private struct PlayerKey : Hashable {
        let player: Player
        private let id: ObjectIdentifier
        
        init(_ player: Player) {
            self.player = player
            id = ObjectIdentifier(player)
        }
    
        public var hashValue: Int {
            return id.hashValue
        }
        
        static func == (lhs: Buzzer.PlayerKey, rhs: Buzzer.PlayerKey) -> Bool {
            return lhs.player === rhs.player
        }
    }
}

protocol BuzzerDelegate {
    
    func onBuzzerChange(buzzer: Buzzer)
}

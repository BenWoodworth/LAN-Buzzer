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
    
    private var playerBuzzTimes = NSMutableDictionary()
    private var lastBuzz: Date?
    
    private(set) var buzzes: [Buzz] = []
    
    init(resetInterval: TimeInterval) {
        self.resetInterval = resetInterval
    }
    
    func buzz(player: Player, buzzTime: Date) {
        if lastBuzz != nil && buzzTime.timeIntervalSince(lastBuzz!) < resetInterval {
            playerBuzzTimes.removeAllObjects()
            lastBuzz = nil
        }
        
        let previousBuzz = playerBuzzTimes[player] as! Date?
        if previousBuzz == nil || previousBuzz! > buzzTime {
            playerBuzzTimes[player] = buzzTime
            
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
            .map { _, value in (value as! Date) }
            .min()!
        
        return playerBuzzTimes
            .map { key, value in
                Buzz(
                    player: key as! Player,
                    offset: (value as! Date).timeIntervalSince(firstBuzz)
                )
            }
            .sorted { $0.offset < $1.offset }
    }
}

protocol BuzzerDelegate {
    
    func onBuzzerChange(buzzer: Buzzer)
}

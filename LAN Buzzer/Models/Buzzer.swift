//
//  Buzzer.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/14/18.
//

import Foundation

class Buzzer {
    let resetInterval: TimeInterval
    var delegate: BuzzerDelegate!
    
    private(set) var buzzes: [Buzz] = []
    private var lastBuzz = Date(timeIntervalSince1970: TimeInterval(exactly: 0)!)
    
    init(resetInterval: TimeInterval) {
        self.resetInterval = resetInterval
    }
    
    func buzz(player: Player, buzzTime: Date) {
        
    }
}

protocol BuzzerDelegate {
    
    func onBuzzerChange(buzzer: Buzzer)
}

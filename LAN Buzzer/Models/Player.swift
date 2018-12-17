//
//  Client.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/14/18.
//

import Foundation
import MulticastDelegateSwift

protocol Player : AnyObject, BuzzerSessionDelegate {
    var delegate: PlayerDelegate? { get set }
    
    var name: String { get set }
    var color: PlayerColor { get set }
}

protocol PlayerDelegate {
    
    func onPlayerJoin(player: Player)
    
    func onPlayerLeave(player: Player)
    
    func onPlayerUpdate(player: Player)
    
    func onPlayerBuzz(player: Player, buzzTime: Date)
}

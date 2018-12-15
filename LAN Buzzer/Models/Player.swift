//
//  Client.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/14/18.
//

import Foundation

protocol Player : AnyObject {
    
    var delegate: PlayerDelegate? { get set }
    
    func updateState(state: PlayerState)
}

protocol PlayerDelegate {
    
    func onPlayerBuzz(time: Date)
    
    func onPlayerUpdateName(name: String)
    
    func onPlayerUpdateColor(color: String)
    
    func onPlayerLeave()
}

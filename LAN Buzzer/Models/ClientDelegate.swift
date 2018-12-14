//
//  ClientDelegate.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/14/18.
//

import Foundation

protocol ClientDelegate {
    
    func onPlayerBuzz(time: Date)
    
    func onPlayerUpdateName(name: String)
    
    func onPlayerUpdateColor(color: String)
    
    func onPlayerLeave()
}

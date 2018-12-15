//
//  Buzzer.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/14/18.
//

import Foundation

class Buzzer {
    private var playerHandles = Dictionary<Int, PlayerHandle>()
    private var nextHandleId = 0
    
    func addPlayer(player: Player) {
        let handleId = nextHandleId
        nextHandleId += 1
        
        let playerHandle = PlayerHandle(
            handleId: handleId,
            buzzer: self,
            player: player
        )
        
        playerHandles[handleId] = playerHandle
        player.delegate = playerHandle
        
        
    }
    
    private struct PlayerHandle : PlayerDelegate {
        let handleId: Int
        let buzzer: Buzzer
        let player: Player
        
        func updateState() {
            
        }
        
        func remove() {
            
        }
        
        func onPlayerBuzz(time: Date) {
            <#code#>
        }
        
        func onPlayerUpdateName(name: String) {
            <#code#>
        }
        
        func onPlayerUpdateColor(color: String) {
            <#code#>
        }
        
        func onPlayerLeave() {
            <#code#>
        }
    }
}

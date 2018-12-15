//
//  PlayerController.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/14/18.
//

import Foundation

class ClientController {
    private let client: Client
    
    var delegate: ClientControllerDelegate?
    
    init(client: Client) {
        self.client = client
        client.delegate = ClientHandler(clientController: self)
    }
    
    func updateClientState(state: ClientState) {
        client.state = state
    }
    
    private struct ClientHandler : ClientDelegate {
        let clientController: ClientController
        
        private var player: Player {
            return clientController.client.state.player
        }
        
        func onPlayerBuzz(time: Date) {
            print("Player '\(player.name)' Buzzed: \(time)")
        }
        
        func onPlayerUpdateName(name: String) {
            print("Player '\(player.name)' Updated Name: \(name)")
        }
        
        func onPlayerUpdateColor(color: String) {
            print("Player '\(player.name)' Updated Color: \(color)")
        }
        
        func onPlayerLeave() {
            print("Player '\(player.name)' Quit")
        }
    }
}


protocol ClientControllerDelegate {
    
    func onClientExit()
}

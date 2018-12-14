//
//  PlayerController.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/14/18.
//

import Foundation

class ClientController : ClientDelegate {
    private let buzzerController: BuzzerController
    let client: Client
    
    init(
        buzzerController: BuzzerController,
        client: Client
    ) {
        self.buzzerController = buzzerController
        self.client = client
    }
    
    func onPlayerBuzz(time: Date) {
        print("Player '\(client.player.name)' Buzzed: \(time)")
    }
    
    func onPlayerUpdateName(name: String) {
        print("Player '\(client.player.name)' Updated Name: \(name)")
    }
    
    func onPlayerUpdateColor(color: String) {
        print("Player '\(client.player.name)' Updated Color: \(color)")
    }
    
    func onPlayerLeave() {
        print("Player '\(client.player.name)' Quit")
    }
}

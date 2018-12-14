//
//  ServerController.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/14/18.
//

import Foundation

class BuzzerController {
    //    private var clientControllers = Dictionary<Int, ClientController>()
    private var clientControllers = [ClientController]()
    private var nextPlayerNumber = 1
    
    func addClient(client: Client) {
        let playerNumber = nextPlayerNumber
        nextPlayerNumber += 1
        
        let player: Player = Player(
            name: "Player \(playerNumber)",
            color: "FF0000"
        )
        
        let clientController = ClientController(
            buzzerController: self,
            client: client,
            player: player
        )
        
        clientControllers.insert(clientController, at: clientControllers.count)
        client.delegate = clientController
    }
    
    func removeClient(client: Client) {
        clientControllers = clientControllers
            .filter { return $0.client !== client }
    }
}

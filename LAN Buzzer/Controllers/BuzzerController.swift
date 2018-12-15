//
//  ServerController.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/14/18.
//

import Foundation

class BuzzerController {
    //    private var clientControllers = Dictionary<Int, ClientController>()
    private var players = [(player: Player, clientController: ClientController)]()
    private var nextPlayerNumber = 1
    
    private var buzzes: [Buzz] = []
    
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
    
    private func updateClients() {
        let players = clientControllers
            .map { $0.client.state.player }
        
        for clientController in clientControllers {
//            clientController.
        }
    }
    
    private struct ClientControllerHandler : ClientControllerDelegate {
        let buzzerController: BuzzerController
        let clientId: Int
        var player: Player
        
        func onClientExit() {
            <#code#>
        }
    }
}

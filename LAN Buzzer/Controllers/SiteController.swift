//
//  IndexController.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/13/18.
//

import Foundation
import Swifter

class SiteController {
    let server: HttpServer
    
    let address: String = "TODO"
    
    init(buzzerSession: BuzzerSession, port: UInt16) throws {
        server = HttpServer()
        
        server["/"] = shareFile(Bundle.main.path(forResource: "BuzzerSite", ofType: "html")!)
        
        server["/socket"] = websocket { session in
            let player = WebSocketPlayer(webSocketSession: session)
            player.delegate = buzzerSession
            return player
        }
        
        try server.start(port)
    }
}

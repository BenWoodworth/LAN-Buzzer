//
//  IndexController.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/13/18.
//

import Foundation
import Swifter

class SiteController {
    let buzzerSession: BuzzerSession
    let server: HttpServer
    
    let buzzerAddress: String
    
    init(buzzerSession: BuzzerSession, port: UInt16) throws {
        self.buzzerSession = buzzerSession
        
        buzzerAddress = "http://TODO:\(port)/"
        
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

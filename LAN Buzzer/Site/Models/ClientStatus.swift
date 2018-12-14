//
//  ClientStatus.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/11/18.
//

import Foundation

struct ClientStatus {
    let sessionId: SessionId
    let clientTime: Int
    
    let newName: String?
    let newColor: String?
    
    let isBuzzing: Bool?
}

extension ClientStatus : Codable {
    
    enum CodingKeys: String, CodingKey {
        case sessionId = "session_id"
        case clientTime = "client_time"
        case newName = "new_name"
        case newColor = "new_color"
        case isBuzzing = "is_buzzing"
    }
}

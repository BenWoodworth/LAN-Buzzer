//
//  Client.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/11/18.
//

import Foundation

struct Player {
    let id: PlayerId
    let name: String
    let color: String
}

extension Player : Codable {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case color = "color"
    }
}

//
//  WebSocketPlayer.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/16/18.
//

import Foundation
import MulticastDelegateSwift
import Swifter

private let jsonEncoder = JSONEncoder()
private let jsonDecoder = JSONDecoder()

class WebSocketPlayer : Player, WebSocketSessionDelegate {
    private let webSocketSession: WebSocketSession
    private var timeDeltaMs = 0.0
    
    var delegate: PlayerDelegate?
    
    var name = ""
    var color = PlayerColor(rgb: 0xFFFFFF)
    
    init(webSocketSession: WebSocketSession) {
        self.webSocketSession = webSocketSession
    }
    
    func onBuzzerSessionUpdate(buzzerSession: BuzzerSession) {
        let clientState = JsonClientState(
            buzzerSession: buzzerSession,
            player: self
        )
        
        DispatchQueue.main.async {
            self.webSocketSession.writeText(clientState.toJson())
        }
    }
    
    func onWebSocketSessionConnect(session: WebSocketSession) {
        DispatchQueue.main.async {
            self.delegate?.onPlayerJoin(player: self)
        }
    }
    
    func onWebSocketSessionDisconnect(session: WebSocketSession) {
        DispatchQueue.main.async {
            self.delegate?.onPlayerLeave(player: self)
        }
    }
    
    func onWebSocketSessionText(session: WebSocketSession, data: String) {
        let time = Date()
        print("Update Data:\n    \(data)")
        
        guard let playerUpdate = try? JsonPlayerUpdate.fromJson(data) else {
            print("Unable to decode JsonPlayerUpdate from JSON:\n\(data)")
            return
        }
        
        var updated = false
        
        if let newName = playerUpdate.new_name {
            name = newName
            updated = true
        }
        
        if let newColor = playerUpdate.new_color {
            color = newColor.toPlayerColor()
            updated = true
        }
        
        DispatchQueue.main.async {
            if updated {
                self.delegate?.onPlayerUpdate(player: self)
            }
            
            if playerUpdate.is_buzzing ?? false {
                let deltaTime = time.addingTimeInterval(TimeInterval(exactly: self.timeDeltaMs / 1000.0)!)
                self.delegate?.onPlayerBuzz(player: self, buzzTime: deltaTime)
            }
        }
    }
    
    func onWebSocketSessionBinary(session: WebSocketSession, data: [UInt8]) {
    }
    
    func onWebSocketSessionPong(session: WebSocketSession, data: [UInt8]) {
    }
    
    private struct JsonClientState : Codable {
        let player: JsonPlayer
        let players: [JsonPlayer]
        let buzzes: [JsonBuzz]
        
        init(buzzerSession: BuzzerSession, player: Player) {
            self.player = JsonPlayer(player: player)
            
            players = buzzerSession.players
                .map { JsonPlayer(player: $0) }
            
            buzzes = buzzerSession.buzzes
                .map { JsonBuzz(buzz: $0) }
        }
        
        func toJson() -> String {
            let data = try! jsonEncoder.encode(self)
            return String(data: data, encoding: String.Encoding.utf8)!
        }
    }
    
    private struct JsonPlayer : Codable {
        let name: String
        let color: JsonPlayerColor
        
        init(player: Player) {
            name = player.name
            color = JsonPlayerColor(playerColor: player.color)
        }
    }
    
    private struct JsonPlayerColor : Codable {
        let red: UInt8
        let green: UInt8
        let blue: UInt8
        
        init(playerColor: PlayerColor) {
            red = playerColor.red
            green = playerColor.green
            blue = playerColor.blue
        }
        
        func toPlayerColor() -> PlayerColor {
            return PlayerColor(
                red: red,
                green: green,
                blue: blue
            )
        }
    }
    
    private struct JsonBuzz : Codable {
        let player: JsonPlayer
        let offset_ms: UInt64
        
        init(buzz: Buzz) {
            player = JsonPlayer(player: buzz.player)
            offset_ms = UInt64(buzz.offset * 1000.0)
        }
    }
    
    private struct JsonPlayerUpdate : Codable {
        let time: UInt64
        
        let new_name: String?
        let new_color: JsonPlayerColor?
        
        let is_buzzing: Bool?
        
        static func fromJson(_ json: String) throws -> JsonPlayerUpdate {
            let data = json.data(using: String.Encoding.utf8)!
            return try jsonDecoder.decode(JsonPlayerUpdate.self, from: data)
        }
    }
}

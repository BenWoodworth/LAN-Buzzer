//
//  Client.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/14/18.
//

import Foundation

protocol Client : AnyObject {
    
    var delegate: ClientDelegate? {
        get
        set
    }
    
    func updateState(state: ClientState)
}

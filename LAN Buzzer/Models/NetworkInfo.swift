//
//  NetworkInfo.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/17/18.
//

import Foundation

protocol NetworkInfo {
    
    var isConnected: Bool { get }
    
    var connectionType: String { get }
    
    var name: String { get }
    
    var deviceAddress: String { get }
}

//
//  PlayerColor.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/14/18.
//

import Foundation

struct PlayerColor {
    let red: UInt8
    let green: UInt8
    let blue: UInt8
    
    func copy(
        red: UInt8? = nil,
        green: UInt8? = nil,
        blue: UInt8? = nil
    ) -> PlayerColor {
        return PlayerColor(
            red: red ?? self.red,
            green: green ?? self.green,
            blue: blue ?? self.blue
        )
    }
}

extension PlayerColor {
    
    init(rgb: UInt32) {
        red   = UInt8(rgb & 0xFF0000 >> 16)
        green = UInt8(rgb & 0x00FF00 >> 8)
        blue  = UInt8(rgb & 0x0000FF)
    }
    
    init(hue: Double, saturation: Double, value: Double) {
        func mod(_ x: Double, _ m: Double) -> Double {
            return x < 0 ?
                x.truncatingRemainder(dividingBy: m) + m :
                x.truncatingRemainder(dividingBy: m)
        }
        
        func calc(hueOffset: Double) -> UInt8 {
            let hue360 = mod(hue + hueOffset, 360.0)
            let hue1 = mod(hue + hueOffset, 60.0) / 60.0
            
            let hueInfluence =
                hue360 <  60.0 ? hue1 :
                hue360 < 120.0 ? 1.0 :
                hue360 < 180.0 ? 1.0 - hue1 :
                0.0
            
            let result = (hueInfluence * saturation * value) + (1.0 - saturation)
            return UInt8(0xFF * result)
        }
        
        red   = calc(hueOffset: -60.0)
        green = calc(hueOffset:  60.0)
        blue  = calc(hueOffset: 180.0)
    }
}

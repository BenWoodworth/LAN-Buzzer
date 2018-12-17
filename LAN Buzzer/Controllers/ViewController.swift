//
//  ViewController.swift
//  LAN Buzzer
//
//  Created by Student on 11/1/18.
//

import UIKit

class ViewController: UIViewController {
    
    private let port: UInt16 = 12345
    
    private var siteController: SiteController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let buzzer = Buzzer(resetInterval: TimeInterval(10.0))
        let buzzerSession = BuzzerSession(buzzer: buzzer)
        
        do {
            siteController = try SiteController(buzzerSession: buzzerSession, port: port)
            print("Hosting on port \(port)")
        } catch {
            print("Unable to serve on port \(port)")
            return
        }
    }
}


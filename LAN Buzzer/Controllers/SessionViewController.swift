//
//  SessionController.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/17/18.
//

import UIKit
import Reachability

class SessionViewController: UITableViewController, BuzzerDelegate, BuzzerSessionDelegate {
    weak var siteController: SiteController!
    private var reachability: Reachability?
    
    private var buzzerSession: BuzzerSession {
        return siteController.buzzerSession
    }
    
    private var buzzer: Buzzer {
        return buzzerSession.buzzer
    }
    
    @IBOutlet weak var textNetwork: UITextField!
    @IBOutlet weak var textHostUrl: UITextField!
    @IBOutlet weak var textResetInterval: UITextField!
    //@IBOutlet weak var textPlayersConnected: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        buzzer.delegate.addDelegate(self)
        buzzerSession.delegate.addDelegate(self)
        
        setupReachability()
        
        updateTextNetwork()
        updateTextHostUrl()
        updateTextResetInterval()
//        updateTextPlayersConnected()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    private func setupReachability() {
        reachability?.stopNotifier()
        reachability = Reachability()
        
        reachability?.whenReachable = { r in
            self.updateTextNetwork()        }
        
        reachability?.whenUnreachable = { r in
            self.updateTextNetwork()
        }
    }
    
    private func updateTextNetwork() {
        if let r = reachability {
            switch r.connection {
            case .wifi:
                textNetwork.text = "WiFi: \(r.description)"
            case .cellular:
                textNetwork.text = "Mobile: \(r.description)"
            case .none:
                textNetwork.text = "Disconnected: \(r.description)"
            }
        } else {
            textNetwork.text = "Unknown"
        }
    }
    
    private func updateTextHostUrl() {
        textHostUrl.text = siteController.buzzerAddress
    }
    
    private func updateTextResetInterval() {
        textResetInterval.text = String(Double(buzzer.resetInterval))
    }
    
//    private func updateTextPlayersConnected() {
//        print(buzzerSession.players.count)
//        textPlayersConnected.text = String(buzzerSession.players.count)
//    }
    
    func onBuzzerChange(buzzer: Buzzer) {
        updateTextResetInterval()
    }
    
    func onBuzzerSessionUpdate(buzzerSession: BuzzerSession) {
        updateTextPlayersConnected()
    }
}

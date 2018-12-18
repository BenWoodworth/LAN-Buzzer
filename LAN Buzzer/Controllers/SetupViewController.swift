//
//  ViewController.swift
//  LAN Buzzer
//
//  Created by Student on 11/1/18.
//

import UIKit
import Reachability

class SetupViewController: UITableViewController {
    private var reachability: Reachability?
    
    private var port: UInt16 = 8080
    private var resetInterval: Double = 5.0
    
    private var siteController: SiteController!
    
    @IBOutlet weak var textNetwork: UITextField!
    @IBOutlet weak var textPort: UITextField!
    @IBOutlet weak var textResetInterval: UITextField!
    @IBOutlet weak var buttonStart: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupReachability()
        
        updateTextNetwork()
        updateTextPort()
        updateTextResetInterval()
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
    
    private func updateTextPort() {
        textPort.text = String(port)
    }
    
    private func updateTextResetInterval() {
        textResetInterval.text = String(resetInterval)
    }
    
    @IBAction func onPortChange(_ sender: UITextField) {
        if sender.text != nil,
            let newPort = UInt16(sender.text!),
            1025...25565 ~= newPort {
            
            port = newPort
        }
        
        updateTextPort()
    }
    
    @IBAction func onResetIntervalChange(_ sender: UITextField) {
        if sender.text != nil,
            let newInterval = Double(sender.text!),
            newInterval > 0 {
            
            resetInterval = newInterval
        }
        
        updateTextResetInterval()
    }
    
    @IBAction func onPressStart(_ sender: UIBarButtonItem) {
        let buzzer = Buzzer(resetInterval: TimeInterval(resetInterval))
        let buzzerSession = BuzzerSession(buzzer: buzzer)
        
        do {
            siteController = try SiteController(buzzerSession: buzzerSession, port: port)
            performSegue(withIdentifier: "session-segue", sender: self)
        } catch let error {
            siteController = nil
            
            let alert = UIAlertController(
                title: "Alert",
                message: "Srror starting buzzer:\n\(error.localizedDescription)",
                preferredStyle: .alert
            )
            
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: nil
                )
            )
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sessionViewController = segue.destination as? SessionViewController,
            let setupViewController = sender as? SetupViewController {
            
            sessionViewController.siteController = setupViewController.siteController
        }
    }
}


//
//  ViewController.swift
//  KKMessages
//
//  Created by  Kalpesh on 04/05/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set up the UI (e.g., a button to trigger the alert)
        setupUI()
    }

    func setupUI() {
        // Create a button to trigger the alert
        let showAlertButton = UIButton(type: .system)
        showAlertButton.frame = CGRect(x: 100, y: UIScreen.main.bounds.height/2, width: 200, height: 50)
        showAlertButton.setTitle("Show Alert", for: .normal)
        showAlertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        view.addSubview(showAlertButton)
    }
    
    @objc func showAlert() {
        showAlertWithTitle(title: AlertType.custom.title, message: AlertType.custom.message, alert_type: .custom)
        
    }

}


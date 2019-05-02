//
//  Alert.swift
//  SMSProject
//
//  Created by Ade Adegoke on 26/04/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    
    static func showAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        DispatchQueue.main.async {
        vc.present(alert, animated: true, completion: nil)
        }
    
    }
    
//    static func error(vc: UIViewController, message: String) {
//        showAlert(on: vc, with: "Error", message: message)
//    }
//
//    static func messageSent(vc: UIViewController, message: String) {
//        showAlert(on: vc, with: "Message Sent", message: message)
//    }
}

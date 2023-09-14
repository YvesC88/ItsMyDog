//
//  Utilities.swift
//  ItsMyDog
//
//  Created by Yves Charpentier on 01/09/2023.
//

import UIKit

class Utilities: UIViewController {
    
    static let shared = Utilities()
    
    func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

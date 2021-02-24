//
//  LoginViewController+Presenter.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/07.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension LoginViewController: UserPresenter {
    var errorMessage: String {
        get {
            return "Server Error"
        }
        
    }
    
    @IBAction func doLogin(_ sender: Any) {
        if login(user: UserModel(username: username.text!, password: password.text!)) {
            performSegue(withIdentifier: "loginSegue", sender: self)
        } else {
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
    }
    
    @IBAction func didLogInAnonymous(_ sender: Any) {
        Auth.auth().signInAnonymously(completion: {(user, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            self.performSegue(withIdentifier: "chatSegue", sender: self)
        })
    }
    
    
}

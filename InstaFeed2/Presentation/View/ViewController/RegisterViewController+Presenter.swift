//
//  RegisterViewController+Presenter.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/07.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation
import UIKit

extension RegisterViewController: UserPresenter {
    var errorMessage: String {
        return "Server Error"
    }
    
    
    @IBAction func didRegister(_ sender: Any) {
        
        register(user: UserModel(username: username.text!, password: password.text!))
        //return to login
        performSegue(withIdentifier: "backLoginSegue", sender: self)
    }
}

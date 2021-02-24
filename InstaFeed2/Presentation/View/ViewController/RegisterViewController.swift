//
//  RegisterViewController.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/11/29.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

//    @IBAction func didRegister(_ sender: Any) {
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let user = User(context: context)
//        user.username = username.text
//        user.password = password.text
//
//        //save data
//        (UIApplication.shared.delegate as! AppDelegate).saveContext()
//        
//        //return to login
//        performSegue(withIdentifier: "backLoginSegue", sender: self)
//    }
    
}

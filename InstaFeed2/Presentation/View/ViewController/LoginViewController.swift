//
//  LoginViewController.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/11/29.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
//    @IBAction func doLogin(_ sender: Any) {
//        do {
//            
//            let result = try context.fetch(User.fetchRequest())
//            guard let res = result as? [User] else {return}
//            for var obj in res {
//                if obj.username == username.text && obj.password == password.text {
//                    //perform segue
//                    performSegue(withIdentifier: "loginSegue", sender: self)
//                    break;
//                }
//            }
//            
//        } catch {
//        print("Fail")
//        }
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "chatSegue" {
            let navVc = segue.destination as! UINavigationController
            let channelVc = navVc.viewControllers.first as! ListChatViewController
            
            channelVc.senderDisplayName = username!.text
        }
    }
    

    
}

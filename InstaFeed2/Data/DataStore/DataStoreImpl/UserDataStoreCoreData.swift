//
//  UserDataStoreCoreData.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/06.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class UserDataStoreCoreData {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}

extension UserDataStoreCoreData: UserDataStore {
    func login(username: String, password: String) -> AuthorizeResultModel {
        let result = AuthorizeResultModel(result: false, message: "");
        do {
            let userData = try self.context.fetch(User.fetchRequest())
            guard let users = userData as? [User] else {
                result.message = "Parse data from CoreData is not User"
                return result
                
            }
            for var obj in users {
                if obj.username == username && obj.password == password {
                    result.result = true
                    break;
                }
            }
        } catch {
            print("Fail")
            result.message = "Core Data fetch data fail"
        }
        return result
    }
    
    func register(username: String, password: String) {
        let user = User(context: context)
        user.username = username
        user.password = password
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    
    
    
    
    
}

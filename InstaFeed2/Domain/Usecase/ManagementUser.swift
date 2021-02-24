//
//  ManagementUser.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/07.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation
class ManagementUser {
    var userCoreData: UserDataStore {
        return DIContainer.resolve(serviceType: UserDataStore.self)
    }
    
    func login(userModel: UserModel) -> Bool {
        let result = self.userCoreData.login(username: userModel.username, password: userModel.password)
        print(result.message)
        return result.result
    }
    
    func register(userModel: UserModel) {
        self.userCoreData.register(username: userModel.username, password: userModel.password)
    }
}

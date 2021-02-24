//
//  UserPresenter.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/07.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation
protocol UserPresenter {
    var errorMessage: String { get }
}

extension UserPresenter {
    
    
    func login(user: UserModel) -> Bool {
        return ManagementUser().login(userModel: user)
    }
    
    func register(user: UserModel) {
        ManagementUser().register(userModel: user)
    }
}

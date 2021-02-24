//
//  Dat.swift
//  InstaFeed2
//
//  Created by Huynh Thanh Dat on 2018/01/21.
//  Copyright © 2018 huynhdat. All rights reserved.
//

import Foundation
struct Dat: Codable {
    var name: String
    var age: Int
    var car: Bool
    
    init(name: String, age: Int, car: Bool) {
        self.name = name
        self.age = age
        self.car = car
    }
}

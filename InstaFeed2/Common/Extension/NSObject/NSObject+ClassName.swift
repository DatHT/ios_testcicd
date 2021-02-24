//
//  NSObject+ClassName.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/04.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation

extension NSObject {
    
    class func className() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

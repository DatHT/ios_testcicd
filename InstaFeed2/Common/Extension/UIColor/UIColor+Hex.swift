//
//  UIColor+Hex.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/04.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import UIKit

//カラー取得
extension UIColor {
    
    class func hexString(hexStr : String, alpha : CGFloat = 1.0) -> UIColor {
        let hex = hexStr.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex as String)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r, green:g, blue:b, alpha:alpha)
        }else {
            return UIColor.white
        }
    }
}

//
//  GenericDataType.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/04.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation

protocol GenericDataType {
    associatedtype typeData
    var data: typeData {get set}
}

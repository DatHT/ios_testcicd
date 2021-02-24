//
//  DownloadResource.swift
//  InstaFeed2
//
//  Created by Huynh Thanh Dat on 2018/01/21.
//  Copyright © 2018 huynhdat. All rights reserved.
//

import Foundation

class Resources {
    let downloadUrl: URL
    var downloaded = false
    
    init(downloadUrl: URL) {
        self.downloadUrl = downloadUrl
    }
}

//
//  Download.swift
//  InstaFeed2
//
//  Created by Huynh Thanh Dat on 2018/01/21.
//  Copyright © 2018 huynhdat. All rights reserved.
//

import Foundation

class Download {
    var resource: Resources
    init(resource: Resources) {
        self.resource = resource
    }
    
    var task: URLSessionDownloadTask?
    var isDownloading = false
    var resumeData: Data?
}

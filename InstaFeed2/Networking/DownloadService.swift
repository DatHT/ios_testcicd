//
//  DownloadService.swift
//  InstaFeed2
//
//  Created by Huynh Thanh Dat on 2018/01/21.
//  Copyright © 2018 huynhdat. All rights reserved.
//

import Foundation

class DownloadService {
    var activeDownloads: [URL: Download] = [:]
    var downloadSession: URLSession!
    
    func startDownload(_ resource: Resources) {
        let download = Download(resource: resource)
        download.task = downloadSession.downloadTask(with: resource.downloadUrl)
        download.task!.resume()
        download.isDownloading = true
        activeDownloads[download.resource.downloadUrl] = download
    }
}

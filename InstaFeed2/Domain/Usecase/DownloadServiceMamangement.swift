//
//  DownloadServiceMamangement.swift
//  InstaFeed2
//
//  Created by Huynh Thanh Dat on 2018/01/21.
//  Copyright © 2018 huynhdat. All rights reserved.
//

import Foundation
import UIKit

class DownloadServiceMamangement: NSObject {
    let downloadService = DownloadService()
    
    let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    func localFilePath(for url: URL) -> URL {
        return documentPath.appendingPathComponent(url.lastPathComponent)
    }
    
    lazy var downloadSession: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "backgroundDownloadSession")
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    override init() {
        super.init()
        self.downloadService.downloadSession = self.downloadSession
        
    }
}

extension DownloadServiceMamangement: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("[]Finished downloading to \(location).")
        guard let sourceUrl = downloadTask.originalRequest?.url else {return }
        let download = downloadService.activeDownloads[sourceUrl]
        downloadService.activeDownloads[sourceUrl] = nil
        let destinationUrl = localFilePath(for: sourceUrl)
        print("[]destination url \(destinationUrl)")
        
        let fileManager = FileManager.default
        try? fileManager.removeItem(at: destinationUrl)
        do {
            try fileManager.copyItem(at: location, to: destinationUrl)
            download?.resource.downloaded = true
        }catch let error {
            print("Could not copy file to disk: \(error.localizedDescription)")
        }
        
        
        //Notify to user
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            if let appDeletegate = UIApplication.shared.delegate as? AppDelegate
                , let completeHandler = appDeletegate.backgroundSessionCompleteHandler {
                appDeletegate.backgroundSessionCompleteHandler = nil
                completeHandler()
            }
        }
    }
    
    
}

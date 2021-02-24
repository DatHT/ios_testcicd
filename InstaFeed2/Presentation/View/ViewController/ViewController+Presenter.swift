//
//  ViewController+Presenter.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/05.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation
import MBProgressHUD
import UIKit

extension ViewController: MoviePresenter {
    
    
    func loadData() {
//
//        DispatchQueue.global(qos: .default).async {
//            let movieData = self.getListMovieNowPlaying(p: self.page)
//            DispatchQueue.main.async {
//                self.movies?.append(contentsOf: movieData)
//                self.filterMovies = self.movies
//                self.tableView?.reloadData()
//                MBProgressHUD.hide(for: self.view, animated: true)
//            }
//        }
        
        getMoviesNowPlayingRx(p: self.page).subscribe(onSuccess: { data in
            self.movies?.append(contentsOf: data)
            self.filterMovies = self.movies
            self.tableView?.reloadData()
//            MBProgressHUD.hide(for: self.view, animated: true)
        }) { error in
//            MBProgressHUD.hide(for: self.view, animated: true)
        }
        
    }
    
    func alertMock() {
        getMockServerData().subscribe(onSuccess: { data in
            let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }) { error in
            
        }
    }
}


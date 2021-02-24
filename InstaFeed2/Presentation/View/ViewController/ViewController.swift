//
//  ViewController.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/11/28.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var searchbar: UISearchBar!
    var filterBtn: UIButton
    
    var movies: [Movie]?
    var filterMovies: [Movie]!
    
    var page : Int
    var refresher: UIRefreshControl!
    static let FetchThreshold = 5
    
    @IBOutlet weak var tableView: UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        self.page = 1
        self.filterBtn = UIButton(type: .custom)
        movies = [Movie]()
        filterMovies = [Movie]()
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchbar
        
        tableView.dataSource = self
        tableView.delegate = self
        searchbar.delegate = self
        refresher = UIRefreshControl()
        self.refresher?.addTarget(self, action: #selector(completeReload), for: UIControlEvents.valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refresher
        } else {
            tableView.addSubview(refresher)
        }
        
        //        filterBtn.frame = CGRect(x: 100, y: 430, width: 80, height: 30)
//        filterBtn.layer.cornerRadius = 5
//        filterBtn.layer.borderColor = UIColor.white.cgColor
//        filterBtn.layer.borderWidth = 2
//        filterBtn.titleLabel?.text = "Filter"
//        filterBtn.titleLabel?.textColor = UIColor.white
//        let item = UIBarButtonItem(customView: filterBtn)
//        self.navigationItem.setLeftBarButton(item, animated: false)
        
        loadData()
        alertMock()
        
    }
    
    @objc func completeReload() {
        loadData()
        tableView.reloadData()
        refresher.endRefreshing()
    }
    
//    func loadData() {
//        let urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=d7b479477d49a44b62e8022d0d182848&page=\(page)"
//        guard let url = URL(string: urlString) else {return}
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            self.handleData(data: data, response: response, error: error)
//            }.resume()
//        
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterMovies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstaCell", for: indexPath) as! MovieViewCell
        cell.movie = filterMovies?[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (movies!.count - indexPath.row) <= ViewController.FetchThreshold {
            //fetch data
            page = page + 1
            loadData()
        }
    }

//    private func handleData(data: Data?, response: URLResponse?, error : Error?) {
//        if error != nil {
//            print(error!.localizedDescription)
//        }
//        guard let data = data else {return}
//        do {
//            let movieData = try JSONDecoder().decode(MovieResult.self, from: data)
//            DispatchQueue.main.async {
//                self.movies?.append(contentsOf: movieData.results)
//                self.filterMovies = self.movies
//                self.tableView?.reloadData()
//                MBProgressHUD.hide(for: self.view, animated: true)
//            }
//        }catch let jsonError {
//            print(jsonError)
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetailSegue" {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                let desVC = segue.destination as! MovieDetailViewController
                desVC.movieData = movies?[indexPath.row]
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterMovies = searchText.isEmpty ? movies : movies?.filter({(item: Movie) -> Bool in
            return item.title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        
        tableView.reloadData()
    }
    
    @IBAction func filterValueDidAction(_ sender: Any) {
    }
    
    @IBAction func didCancel(segue: UIStoryboardSegue) {
    }
}


//
//  WalkthroughViewController.swift
//  InstaFeed2
//
//  Created by Huynh Thanh Dat on 2018/01/16.
//  Copyright © 2018 huynhdat. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollViewW: UIScrollView!
    @IBOutlet weak var pageControlW: UIPageControl!
    
    let arrImage = ["maxresdefault-2", "pageviewcontroller-1"]
    override func viewDidLoad() {
        super.viewDidLoad()
        loadScrollView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadScrollView() {
        let pageCount : CGFloat = CGFloat(arrImage.count)
        scrollViewW.backgroundColor = UIColor.clear
        scrollViewW.delegate = self as! UIScrollViewDelegate
        scrollViewW.isPagingEnabled = true
        scrollViewW.contentSize = CGSize(width: scrollViewW.frame.size.width * pageCount, height : scrollViewW.frame.size.height)
        scrollViewW.showsHorizontalScrollIndicator = false
        
        pageControlW.numberOfPages = Int(pageCount)
        pageControlW.addTarget(self, action: #selector(self.pageChanged), for: .valueChanged)
        
        
        for i in 0..<Int(pageCount) {
            print(self.scrollViewW.frame.size.width)
            let image = UIImageView(frame: CGRect(x: self.scrollViewW.frame.size.width * CGFloat(i),y: 0, width: self.scrollViewW.frame.size.width, height: self.scrollViewW.frame.size.height))
            image.image = UIImage(named: arrImage[i])!
            image.contentMode = UIViewContentMode.scaleAspectFit
            self.scrollViewW.addSubview(image)
        }
    }
    
    //MARK: Page tap action
    @objc func pageChanged() {
        let pageNumber = pageControlW.currentPage
        var frame = scrollViewW.frame
        frame.origin.x = frame.size.width * CGFloat(pageNumber)
        frame.origin.y = 0
        scrollViewW.scrollRectToVisible(frame, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let viewWidth: CGFloat = scrollView.frame.size.width
        // content offset - tells by how much the scroll view has scrolled.
        let pageNumber = floor((scrollView.contentOffset.x - viewWidth / 50) / viewWidth) + 1
        pageControlW.currentPage = Int(pageNumber)
    }
}

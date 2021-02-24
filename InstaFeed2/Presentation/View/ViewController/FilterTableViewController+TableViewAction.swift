//
//  FilterTableViewController+TableViewAction.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/08.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation
import UIKit

extension FilterTableViewController {
    
    func loadCellDescriptors() {
        if let path = Bundle.main.path(forResource: "CellDescriptor", ofType: "plist") {
            cellDescriptors = NSMutableArray(contentsOfFile: path) as! [[[String : AnyObject]]]
            getIndiceOfVisibleRows()
            tableView.reloadData()
        }
        
    }
    
    func getCellDescriotorForIndexPath(indexPath: IndexPath) -> [String: AnyObject] {
        let indexOfVisibleRow = visibleRowsPerSection[indexPath.section][indexPath.row]
        let cellDescriptor = cellDescriptors![indexPath.section][indexOfVisibleRow] as [String: AnyObject]
        return cellDescriptor
    }
    
   
    
    func getIndiceOfVisibleRows() {
        visibleRowsPerSection.removeAll()
        
        for curSectionCell in cellDescriptors {
            var visibleRows = [Int]()
            
            
            for row in 0...(curSectionCell.count - 1) {
                
                if curSectionCell[row]["isVisible"] as! Bool == true {
                    visibleRows.append(row)
                }
            }
            visibleRowsPerSection.append(visibleRows)
        }
        print("-----Visible Row Per section------")
        print(visibleRowsPerSection)
    }
    
    func configurationTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NormalCell", bundle: nil), forCellReuseIdentifier: "idCellNormal")
        tableView.register(UINib(nibName: "RangeCell", bundle: nil), forCellReuseIdentifier: "idCellRange")
        tableView.register(UINib(nibName: "DatePickerCell", bundle: nil), forCellReuseIdentifier: "idCellDatePicker")
        tableView.register(UINib(nibName: "RadioCell", bundle: nil), forCellReuseIdentifier: "idCellRadioBtn")
        
        
    }
}

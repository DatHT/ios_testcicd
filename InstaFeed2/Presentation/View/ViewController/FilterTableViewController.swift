//
//  FilterTableViewController.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/07.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController, CustomCellFilterDelegate {
    func dateWasSelected(selectedDateString: String) {
        print("dasd")
    }
    
    func sliderDidChangeValue(newSliderValue: String) {
        print("aaaa")
    }
    
    var cellDescriptors: [[[String: AnyObject]]]!
    var visibleRowsPerSection = [[Int]]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configurationTableView()
        loadCellDescriptors()
        print("-----Cell Descriptors------")
        print(cellDescriptors)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return visibleRowsPerSection[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Order By"
        case 1:
            return "By Range"
        case 2:
            return "By Release Date"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentCellDescriptor = getCellDescriotorForIndexPath(indexPath: indexPath)
        switch currentCellDescriptor["cellIdentifier"] as! String {
        case "idCellDatePicker":
            return 270.0
        case "idCellRange":
            return 113.0
        case "idCellRadioBtn":
            return 241.0
        case "idCellNormal":
            return 60.0
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCellDescriptor = getCellDescriotorForIndexPath(indexPath: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: currentCellDescriptor["cellIdentifier"] as! String, for: indexPath) as! CustomFilterCell
        if currentCellDescriptor["cellIdentifier"] as! String == "idCellNormal" {
            if let primaryTitle = currentCellDescriptor["primaryTitle"] {
                cell.titleTxt?.text = primaryTitle as? String
            }
            
        }
        else if currentCellDescriptor["cellIdentifier"] as! String == "idCellDatePicker" {
            cell.titleTxt?.text = currentCellDescriptor["primaryTitle"] as? String 
        }
        cell.delegate = self
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexOfTappedRow = visibleRowsPerSection[indexPath.section][indexPath.row]
        if cellDescriptors[indexPath.section][indexOfTappedRow]["isExpandable"] as! Bool == true {
            var shouldExpandAndshowSubRow = false
            if cellDescriptors[indexPath.section][indexOfTappedRow]["isExpanded"] as! Bool == false {
                shouldExpandAndshowSubRow = true
            }
            cellDescriptors[indexPath.section][indexOfTappedRow].updateValue(shouldExpandAndshowSubRow as AnyObject, forKey: "isExpanded")
            
            for i in (indexOfTappedRow + 1)...(indexOfTappedRow + (cellDescriptors![indexPath.section][indexOfTappedRow]["additionalRows"] as! Int)) {
                cellDescriptors[indexPath.section][i].updateValue(shouldExpandAndshowSubRow as AnyObject, forKey: "isVisible")
            }
        }
        
        getIndiceOfVisibleRows()
        
        tableView.reloadSections(NSIndexSet(index: indexPath.section) as IndexSet, with: UITableViewRowAnimation.fade)
    }
    
    
    
    

}

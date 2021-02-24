//
//  CustomFilterCell.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/08.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import UIKit
import DLRadioButton

protocol CustomCellFilterDelegate {
    func dateWasSelected(selectedDateString: String)
    func sliderDidChangeValue(newSliderValue: String)
}

class CustomFilterCell: UITableViewCell {
    @IBOutlet weak var slRange: UISlider!
    
    @IBOutlet weak var titleTxt: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: CustomCellFilterDelegate!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func didHandleSliderChange(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        let dateString = dateFormatter.string(from: datePicker.date)
        if delegate != nil {
            delegate.dateWasSelected(selectedDateString: dateString)
        }
    }
    @IBAction func didHandleDateSet(_ sender: Any) {
        if delegate != nil {
            delegate.sliderDidChangeValue(newSliderValue: "\(Int(slRange.value))")
        }
    }

}

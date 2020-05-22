//
//  ForcastTableviewCell.swift
//  OpenWeather
//
//  Created by Asif on 14/11/19.
//  Copyright © 2019 Sapient. All rights reserved.
//

import UIKit

class ForcastTableviewCell: ReusableTableViewCell {
    
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    /// Configure Cell
    /// - Parameter timeInString:
    /// - Parameter tempratureInString:
    public func configureForcastCell(timeInString:String?,tempratureInString:String?) {
        if let time = timeInString {
            timeLabel.text = time
        } else {
            timeLabel.text = "--"
        }
        if let temprature = tempratureInString {
            tempratureLabel.text = temprature
        } else {
            tempratureLabel.text = "--"
        }
    }
    
}

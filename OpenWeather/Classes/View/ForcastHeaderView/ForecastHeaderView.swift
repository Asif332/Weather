//
//  HeaderView.swift
//  OpenWeather
//
//  Created by Asif on 15/11/19.
//  Copyright © 2019 Sapient. All rights reserved.
//

import UIKit

class ForecastHeaderView : UIView {
    
    //initWithFrame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //common func to init our view
    private func setupView() {
        backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    /// This method used for configure Forcast header view
    /// - Parameter dayText: Day Name
    /// - Parameter dateText: Date
    public func configureForecastHeaderView(dayText:String?,dateText:String?)  {
        let dayNameLabel = UILabel()
        dayNameLabel.frame = CGRect.init(x: 15, y: 5, width: self.frame.width-15, height: 30)
        dayNameLabel.text = dayText
        dayNameLabel.font = UIFont(name: "Georgia-Bold", size: 15)
        dayNameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // my custom colour
        self.addSubview(dayNameLabel)
        let dateLabel = UILabel()
        dateLabel.frame = CGRect.init(x: dayNameLabel.frame.origin.x, y: 30, width: dayNameLabel.frame.width, height: 20)
        dateLabel.text = dateText
        dateLabel.font = UIFont(name: "Georgia", size: 13)
        dateLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // my custom colour
        self.addSubview(dateLabel)
    }
    
    
}

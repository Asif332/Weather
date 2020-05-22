//
//  ForecastViewController+TableviewDelegates.swift
//  OpenWeather
//
//  Created by Asif on 14/11/19.
//  Copyright © 2019 Sapient. All rights reserved.
//

import Foundation
import UIKit

extension ForecastViewController : TableViewDataSourceDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowCount(section: section)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ForecastHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 60))
        let (dayText,dateText) = viewModel.dayAndDateText(index: section)
        headerView.configureForecastHeaderView(dayText: dayText, dateText: dateText)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ForcastTableviewCell.reuseIdentifier, for: indexPath) as? ForcastTableviewCell else { return UITableViewCell() }
        let (time,temp) = viewModel.timeAndTempratureText(section: indexPath.section, row: indexPath.row)
        cell.configureForcastCell(timeInString: time, tempratureInString: temp)
        cell.selectionStyle = .none
        return cell
        
    }

}

//
//  ViewController.swift
//  OpenWeather
//
//  Created by Asif on 14/11/19.
//  Copyright © 2019 Sapient. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let location = Constants.WeatherLocation.londonGB()
    var viewModel = ForecastViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        self.activityIndicator.hidesWhenStopped = true
        doInitialSetup()
    }
    
    fileprivate  func doInitialSetup() {
        if Utility.isNetworkAvailable() {
            self.showHideIndicator(isShow: true)
            requestForecast()
        } else {
            Utility.presentAlert(title: Constants.AlertMessage.alertTitle, content: Constants.AlertMessage.kNoConnection, view: self)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = Constants.NavBarTitle.forcastViewControllerTitle
    }
    
    // MARK - API Call
    fileprivate func requestForecast() {
        // Make final Api
        let finalApi =  ("\(Constants.baseURLString )/forecast?q=\(location.cityName),\(location.countryCode)&APPID=\(Constants.OpenWeatherApiKey)&units=\(Constants.units)")
        // Fetch new data
        viewModel.requestForecastApi(url: finalApi, param: nil, completion: {[weak self] isSuccess, errorMsg  in
            self?.showHideIndicator(isShow: false)
            if isSuccess {
                self?.loadData()
            } else {
                Utility.presentAlert(title: Constants.AlertMessage.alertTitle, content: errorMsg ?? Constants.AlertMessage.serverError, view: self!)
            }
        })
    }
    
    //MARK:Prepare the view UI.
    fileprivate func loadData() {
        DispatchQueue.main.async {
            self.cityNameLabel.text = "\(self.viewModel.dataModel.city?.name ?? "--"),\(self.viewModel.dataModel.city?.country ?? "--")"
           // self.tableView.separatorColor = #colorLiteral(red: 0.1304498613, green: 0.6021913886, blue: 0.6194018722, alpha: 1)
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
    }
    
    /// Show Hide Activity Indicator
    /// - Parameter isShow: bool
    fileprivate func showHideIndicator(isShow:Bool) {
        DispatchQueue.main.async {
            if isShow {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
        }
        
    }
    
}


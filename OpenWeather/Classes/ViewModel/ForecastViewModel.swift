//
//  ForecastViewModel.swift
//  OpenWeather
//
//  Created by Asif on 14/11/19.
//  Copyright © 2019 Sapient. All rights reserved.
//

import Foundation

class ForecastViewModel {
    
    public var dataModel : ForecastModel! = nil
    
    //let index : Int
    //    init(dataModel: ForecastModel, index: Int) {
    //        self.dataModel = dataModel
    //        self.index = index
    //    }
    
    public func instancesData() -> ForecastModel {
        return dataModel
    }
    // http://api.openweathermap.org/data/2.5/forecast?q=London,GB&APPID=28f6fe2ab4d40ebd573e2520b10e14a2&units=metric
    
    public func requestForecastApi(url:String, param:[String:AnyObject]? ,completion: @escaping (_ isSuccess: Bool, _ errorMsg: String?)->()) {
        WebServiceManager.sharedService.requestAPI(url: url, parameter: param, header: nil, httpMethodType: .POST) { (data, error) in
            guard data != nil else {
                completion(false,error?.localizedDescription)
                return
            }
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ForecastModel.self, from: data!)
                self.dataModel = jsonData
                if jsonData.cod == "200" {
                    completion(true,"")
                } else {
                    completion(false,"")
                }
            } catch {
                debugPrint("error:\(error)")
                completion(false,error.localizedDescription)
                
            }
            
        }
    }
    
    //Mark : Bussiness Logics to filter data according to need
    
    /// This method will return day and date text against each index
    /// - Parameter index:
    public func dayAndDateText(index:Int) -> (String,String) {
        let date = self.filterRecordsByDate().keys.sorted()[index]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dateString = dateFormatter.string(from: date)
        return (getDayNameBy(stringDate: dateString, df: dateFormatter),dateString)
    }
    
    /// This method will return time and temprature text against each section and row
    /// - Parameter section:
    /// - Parameter row:
    public func timeAndTempratureText(section:Int,row:Int) -> (String,String) {
        let key = self.filterRecordsByDate().keys.sorted()[section]
        guard let arrayOfRecords = self.filterRecordsByDate()[key] as? [Any] else {
            return ("--","--")
        }
        guard let list = arrayOfRecords[row] as? List else {
            return ("--","--")
        }
        let date = Date(timeIntervalSince1970: Double(list.dt!))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let time = dateFormatter.string(from: date)
        guard let temp = list.main?.temp  else {
            return (time,"--")
        }
        let temprature = String(format: "%.1f", temp) + "°"
        //debugPrint("time =>\(time) and temprature =>\(temprature)")
        return (time,temprature)
        
    }
    
    var sectionArray : [Date] {
        let sortedKeys = self.filterRecordsByDate().keys.sorted()
        //debugPrint("total sections =>\(sortedKeys.count)")
        return sortedKeys
    }
    
    /// This will return all row counts againts each section
    /// - Parameter section:
    public func rowCount(section:Int) -> Int {
        let key = self.filterRecordsByDate().keys.sorted()[section]
        guard let arrayOfRecords = self.filterRecordsByDate()[key] as? [Any] else {
            return 0
        }
        //debugPrint("total rows =>\(arrayOfRecords.count) in sections =>\(section)")
        return arrayOfRecords.count
    }
    
    /// Filtering all the 3 hours temprature by date
    fileprivate func filterRecordsByDate() -> Dictionary<Date, Any> {
        let grouppedForcast = Dictionary(grouping: self.dataModel.list!){ (Element) -> Date in
            let date = Date(timeIntervalSince1970: Double(Element.dt!))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            let localDate = dateFormatter.string(from: date)
            return dateFormatter.date(from: localDate)!
        }
        return grouppedForcast
    }
    
    /// Get Day Name By Date
    /// - Parameter stringDate: its a date in string format
    /// - Parameter df: dateFormatter
    fileprivate func getDayNameBy(stringDate: String, df:DateFormatter) -> String
    {
        let date = df.date(from: stringDate)
        df.dateFormat = "EEEE"
        return df.string(from:date!).uppercased();
    }
    
    
    
}

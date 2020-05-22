//
//  Reachability.swift
//  Utility
//
//  Created by Asif on 14/11/19.
//  Copyright © 2019 Sapient. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    /**
     Class method which checks the internet collection and returns true if internet is reachable
     - returns: - BOOL : true if network is reachable
     */
    static func isNetworkAvailable() -> Bool{
        let status = Reachability().connectionStatus()
        switch status {
        case .unknown, .offline:
            return false;
        case .online(.wwan):
            return  true
        case .online(.wiFi):
            return  true
        }
    }
    
    static func getWeekDayfromCalendarElement(element: Int) -> String {
        
        switch element {
            
        case 1:
            return "Sunday"
            
        case 2:
            return "Monday"
            
        case 3:
            return "Tuesday"
            
        case 4:
            return "Wednesday"
            
        case 5:
            return "Thursday"
            
        case 6:
            return "Friday"
            
        case 7:
            return "Saturday"
            
        default:
            
            return ""
        }
    }
    
    
    private static func dateFormatterOk () -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter
    }
    
    
    static func fromTimestampToCalendarElement(timestamp: String?, component:Calendar.Component ) -> Int {
        
        guard let timestampExists = timestamp else {
            
            return -1
        }
        
        return Calendar.current.component(component, from: dateFormatterOk().date(from: timestampExists) ??  Date())
        
    }
    /**
     Utility function that shows a warning alertController
     
     - parameter title: Title of the popup
     - parameter content Content of the popup
     - parameter view The UIViewController that will present the popup
     */
    static func presentAlert(title: String, content: String, view: UIViewController) {
        
        let alert = UIAlertController(title: title, message: content, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            alert.dismiss(animated: true, completion: nil)
        })
        DispatchQueue.main.async {
            view.present(alert,animated: true)
        }
    }
    
    
}



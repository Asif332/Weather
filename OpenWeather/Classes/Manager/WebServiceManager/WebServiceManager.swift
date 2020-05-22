//
//  WebServiceManager.swift
//  OpenWeather
//
//  Created by Asif on 14/11/19.
//  Copyright © 2019 Sapient. All rights reserved.
//

import UIKit


class WebServiceManager: NSObject {
    
    static let sharedService = WebServiceManager()
    
    typealias WebServiceCompletionBlock = (_ data: Data?,_ error: Error?)->Void
    
    enum HTTPMethodType: Int {
        case GET = 0
        case POST
    }
    
    func requestAPI(url: String,parameter: [String: AnyObject]?,header:[String: String]?, httpMethodType: HTTPMethodType, completion: @escaping WebServiceCompletionBlock) {
        
        let escapedAddress = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        var request = URLRequest(url: URL(string: escapedAddress!)!)
        request.timeoutInterval = 30.0
        debugPrint("url:-  \(url)")
        
        switch httpMethodType {
        case .POST:
            request.httpMethod = "POST"
        case .GET:
            request.httpMethod = "GET"
        }
        if parameter != nil {
            debugPrint("parameter:-   \(parameter!)")
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameter as Any, options: .prettyPrinted)
            } catch let error {
                debugPrint(error.localizedDescription)
                completion(nil,error)
                return
            }
        }
        if header != nil {
            request.allHTTPHeaderFields = header
            debugPrint("header:-  \(header!)")
        }
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil,error)
                return
            }
            debugPrint("response:-  \(String(data: data, encoding: .utf8) ?? "")")
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                debugPrint("Error in fetching response")
                completion(nil,error)
            }
            completion(data,error)
        }
        task.resume()
        
    }
    
}

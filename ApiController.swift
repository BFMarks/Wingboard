//
//  ApiController.swift
//  MorseCode
//
//  Created by Bryan Marks on 8/8/16.
//  Copyright © 2016 Andrei Puni. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class API {
    
    let apiEndPoint = "apiEndPoint"
    let apiUrl:String!
    let consumerKey:String!
    let consumerSecret:String!
    
    var returnData = [:]
    
    init(){
        self.apiUrl = "https://wingboard.herokuapp.com/"
        self.consumerKey = "my consumer key"
        self.consumerSecret = "my consumer secret"
    }
    
    func getOrders(completionHandler: (AnyObject?, NSError?) -> ()) {
        makeCall("orders", completionHandler: completionHandler)
    }

    
    
    func makeCall(section: String, completionHandler: (AnyObject?, NSError?) -> ()) {
//        let params = ["consumer_key":"key", "consumer_secret":"secret"]
        
            Alamofire.request(.GET, "https://wingboard.herokuapp.com/\(section)")
//        Alamofire.request(.GET, "https://wingboard.herokuapp.com/opening")
//           .authenticate(user: consumerKey, password: consumerSecret)
            .responseJSON { response in
                switch response.result {
                case .Success(let value):
                    completionHandler(value, nil)
                case .Failure(let error):
                    completionHandler(nil, error)
                
            }
        }
    }
    
}
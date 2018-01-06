//
//  ChechoPIController.swift
//  WingBoard
//
//  Created by Bryan Marks on 10/20/16.
//  Copyright © 2016 Bryan F. Marks. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
//import Mixpanel

var chechoPoint : String! = "opening"


class ChechoPI {
    
    var apiEndPoint:String! = "apiEndPoint"
    let apiUrl:String!
    let consumerKey:String!
    let consumerSecret:String!
    
//    var returnData = [:]
    
    init() {
        self.apiUrl = "https://wingboard-backend.herokuapp.com/api/categories/"
        self.consumerKey = "my consumer key"
        self.consumerSecret = "my consumer secret"
        self.apiEndPoint = "apiEndPoint"
    }
    
    func getOrders(_ section: String, completionHandler: @escaping (AnyObject?, NSError?) -> ()) {
        makeCall(section, completionHandler: completionHandler)
        print("The current value of getOrders********* is \(section)")
    }
    
    
    
    func makeCall(_ section: String, completionHandler: @escaping (AnyObject?, NSError?) -> ()) {
        //        let params = ["consumer_key":"key", "consumer_secret":"secret"]
        
        print("The current value of makeCall********* is \(section)")
        
        Alamofire.request("https://wingboard-backend.herokuapp.com/\(section)")
            
            .responseJSON { response in
                print(response)
                //to get status code
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201:
                        print("example success")
                    default:
                        print("error with response status: \(status)")
                        
                    }
                }
        func makePostRequestForUserSubmission(_ section: String, completionHandler: (AnyObject?, NSError?) -> ()) {
        }
    }
}
}

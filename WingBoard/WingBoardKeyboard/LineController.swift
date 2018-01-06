//
//  LineController.swift
//  WingBoard
//
//  Created by Bryan Marks on 10/30/16.
//  Copyright © 2016 Bryan F. Marks. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
//import Mixpanel

var linePoint : String! = "opening"


class LineController {
    
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
    
    func getOrders(_ section: Int, completionHandler: @escaping (AnyObject?, NSError?) -> ()) {
        makeCall(section, completionHandler: completionHandler)
        print("The current value of getOrders********* is \(section)")
    }
    
    
    
    func makeCall(_ section: Int, completionHandler: @escaping (AnyObject?, NSError?) -> ()) {
        //        let params = ["consumer_key":"key", "consumer_secret":"secret"]
        
        print("The current value of makeCall********* is \(section)")
        
        Alamofire.request("http://wingboard-backend.herokuapp.com/api/lines?category_ids=\(section)")
            
            .responseJSON { response in
                print(response)
                //to get status code
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201:
                        print("example success")
                    default:
                        print("response status: \(status)")
                        
                    }
                }
        func makePostRequestForUserSubmission(_ section: String, completionHandler: (AnyObject?, NSError?) -> ()) {
        }
    }
}

}







//  ApiController.swift
//
//
//  Created by Bryan Marks on 8/8/16.
//  Copyright © 2016 Bryan Marks. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
//import Mixpanel

var endPoint : String! = "opening"


class API {
    
    var apiEndPoint:String! = "apiEndPoint"
    let apiUrl:String!
    let consumerKey:String!
    let consumerSecret:String!
//    var endPoint : String! = "opening"
    
//    var returnData = [:]
    
    init() {
        self.apiUrl = "https://wingboard.herokuapp.com/"
        self.consumerKey = "my consumer key"
        self.consumerSecret = "my consumer secret"
        self.apiEndPoint = "apiEndPoint"
    }
    
    func getOrders(_ section: String, completionHandler: @escaping (AnyObject?, NSError?) -> ()) {
        
        
//        let token = "05096578a308d8c8b4e4cc92ffd949b9"
//        let mixpanel = Mixpanel.sharedInstanceWithToken(token)
        
        //////No member time
        
//        mixpanel.time(event:"Started JSON")
        
        makeCall(section, completionHandler: completionHandler)
        print("The current value of getOrders********* is \(section)")
    }

    
    
    func makeCall(_ section: String, completionHandler: @escaping (AnyObject?, NSError?) -> ()) {
//        let params = ["consumer_key":"key", "consumer_secret":"secret"]
        
       print("The current value of makeCall********* is \(section)")
        
        Alamofire.request("https://wingboard.herokuapp.com/\(section)")
        
//            Alamofire.request(.GET, "https://wingboard.herokuapp.com/\(section)")
//        Alamofire.request(.GET, "https://wingboard.herokuapp.com/opening")
//           .authenticate(user: consumerKey, password: consumerSecret)
            
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

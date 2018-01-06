//
//  RankingsTableViewController.swift
//  WingBoard
//
//  Created by Bryan Marks on 9/6/16.
//  Copyright © 2016 Bryan F. Marks. All rights reserved.
//


import UIKit
import Mixpanel
import Foundation

class RankingsTableViewController: UITableViewController {
//    
//    var tableView: UITableView  =   UITableView()
//    
//    var newArray: Array<String> = ["Hey how you doing ;)", "Make sure you allow access in settings!", "We can't connect to internet yet :("]
//    var newHeader:[String] = ["BOW TO THE GREATEST"]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        self.view.addSubview(tableView)
//        didTapForUserSubmission()
//    
//    }
//    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//         return self.newArray.count
//    }
//    
//   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
//        
//        cell.textLabel?.numberOfLines=0
//        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
//        
////        cell.textLabel?.text = self.newArray[indexPath.row]
//    
//        cell.layer.borderColor = UIColor.lightGrayColor().CGColor
//        cell.layer.borderWidth = 1
//        cell.layer.cornerRadius = 8
//        
//        return cell
//        
//    }
//    
//     override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print("You selected cell #\(indexPath.row)!")
//       
//        
//    }
//    
//    
//     override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
//    
//     override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//     override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return self.newHeader[0]
//    }
//
//    func didTapForUserSubmission() {
//        
////        self.newHeader[0] = "User Submitted"
//        let api = API()
//        let variableString: String = "usersubmission"
//        api.getOrders(variableString) { responseObject, error in
//            print("responseObject = \(responseObject); error = \(error)")
//            if let JSON = responseObject {
//                print("JSON is \(JSON)")
//                let found = JSON["found"] as? [AnyObject]
//                print("found is \(found)")
//                for item in found! {
//                    let string = item["generalText"]!
//                    print("String is \(string!)")
//                    self.newArray.append(string! as! String)
//                }
////                print("The current value of self.jsonArray is \(self.jsonArray)")
//                print("The current value of JSON is \(JSON)")
//                print("The current value of SELF.NEWARRAY is \( self.newArray)")
//                self.tableView.reloadData()
//            }
//        }
//    }

}

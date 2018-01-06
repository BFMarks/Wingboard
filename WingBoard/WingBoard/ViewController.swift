//
//  ViewController.swift
//  WingBoard
//
//  Created by Bryan Marks on 8/8/16.
//  Copyright © 2016 Andrei Puni. All rights reserved.
//

import UIKit
import Alamofire
import Mixpanel
import iAd
import AppsFlyerTracker

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var submitButton: UIButton?
    @IBOutlet var textField: UITextField!
    @IBOutlet var accessoryView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.textField.delegate = self;
        ////Make cursor move here first
        textField.becomeFirstResponder()
        

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "WingBoardLogo.png")
        imageView.image = image
        navigationItem.titleView = imageView
        
        AppsFlyerTracker.shared().trackEvent("Test", withValue: "test")
        AppsFlyerTracker.shared().trackEvent(AFEventPurchase, withValues: [AFEventParamCurrency : "USD",AFEventParamRevenue: 6 , AFEventParamScore: 100])
        
//        AppsFlyerTracker.sharedTracker().trackAppLaunch()
//        AppsFlyerTracker.sharedTracker().trackEvent("App Opened", withValue: "Date")
//       AppsFlyerTracker.sharedTracker().trackEvent(AFEventPurchase, withValues: [AFEventParamCurrency : "USD", AFEventParamRevenue: 5 ])
        
    }
    
    
    let limitLength = 90
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= limitLength
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
       
        
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func didTapUserSubmission(_ sender: AnyObject) {
        
        let userSubmissionText = self.textField.text
        
        
        print(userSubmissionText )        //READY FOR CHECHO BACKEND
        let params: [String: AnyObject] = ["generalText": textField.text! as AnyObject]
//        let params: [String: AnyObject] = ["line": textField.text!]
        
        let request = Alamofire.request("https://wingboard.herokuapp.com/usersubmission", method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                
                //to get status code
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201:
                        print("example success")
                    default:
                        print("error with response status: \(status)")
                        print("error USER MAY EXIST")
                        
                    }
                }
        
     
        
        self.submitButton!.isEnabled = false
       
        
        let alert: UIAlertView = UIAlertView(title: "Good One!", message: "Wait around a 5 minutes and let someone else have a turn", delegate: nil, cancelButtonTitle: "Ok Fine WingButt");
        
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 50, y: 10, width: 37, height: 37)) as UIActivityIndicatorView
        loadingIndicator.center = self.view.center;
        loadingIndicator.hidesWhenStopped = false
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.setValue(loadingIndicator, forKey: "accessoryView")
        loadingIndicator.startAnimating()
        
        alert.show()
        
        // Delay the dismissal by 5 seconds
        let delay = 5.0 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            alert.dismiss(withClickedButtonIndex: -1, animated: true)
        })
        
       
        self.submitButton!.isEnabled = false
        
        print(self.submitButton?.isEnabled)
        
//        Timer.scheduledTimer(timeInterval: 600.0, target: self, selector: #selector(enableButton), userInfo: nil, repeats: false)
        
        AppsFlyerTracker.shared().trackEvent("App Opened", withValue: "Date")
        AppsFlyerTracker.shared().trackEvent(AFEventPurchase, withValues: [AFEventParamCurrency : "USD",AFEventParamRevenue: 3.99 , AFEventParamScore: 100])

        
        
        }
    
        func enableButton() {
            let button = self.submitButton
            button!.isEnabled = true
        }
    
    
}


}

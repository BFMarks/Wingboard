//
//  ModalSetupViewController.swift
//  WingBoard
//
//  Created by Bryan Marks on 8/11/16.
//  Copyright © 2016 Bryan F. Marks. All rights reserved.
//

import UIKit
import Mixpanel
import AppsFlyerTracker

class ModalSetupViewController: UIViewController {

    @IBAction func dismissModal(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goToSettings(_ sender: AnyObject) {
        if let settingsURL = URL(string: "prefs:root=General&path=Keyboard") {
            UIApplication.shared.openURL(settingsURL)
            let mixpanel = Mixpanel.sharedInstance()
            mixpanel.track("Go to Settings Button")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "WingBoardLogo.png")
        imageView.image = image
        navigationItem.titleView = imageView
        
        AppsFlyerTracker.shared().appleAppID = "1141975796"
        AppsFlyerTracker.shared().appsFlyerDevKey = "Bw36o6Ubt3Wvxhc8vURLnh"
        AppsFlyerTracker.shared().trackAppLaunch()
        AppsFlyerTracker.shared().trackEvent("App Opened", withValue: "Date")
        AppsFlyerTracker.shared().trackEvent(AFEventPurchase, withValues: [AFEventParamCurrency : "USD", AFEventParamRevenue: 3.99 ])
    }
    
}



import UIKit
import StoreKit
import Mixpanel
import AdSupport

class MasterViewController: UITableViewController {
  
//  let showDetailSegueIdentifier = "showDetail"
    let showDetailSegueIdentifier = "goToUserSubmission"
  
  var products = [SKProduct]()
  
  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    if identifier == showDetailSegueIdentifier {
      guard let indexPath = tableView.indexPathForSelectedRow else {
        return false
      }
      
      let product = products[indexPath.row]
      
      return RageProducts.store.isProductPurchased(product.productIdentifier)
    }
    
    return true
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == showDetailSegueIdentifier {
      guard let indexPath = tableView.indexPathForSelectedRow else { return }
      
      let product = products[indexPath.row]
      
      if let name = resourceNameForProductIdentifier(product.productIdentifier),
             let detailViewController = segue.destination as? DetailViewController {
        let image = UIImage(named: name)
        detailViewController.image = image
      }
    }
  }
    
//    override func addPushDevicetoken(deviceToken: NSData)
    
    func getDate(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        let mixpanel = Mixpanel.sharedInstance()
        print(formatter.string(from: date))
        mixpanel.identify("Btron")
        mixpanel.people.set("User login Time", to: formatter.string(from: date))
        mixpanel.people.setOnce(["People prop users First Login": formatter.string(from: date)])
        print("People's USER First Login\(formatter.string(from: date))!")
        mixpanel.registerSuperPropertiesOnce(["User's First Login": formatter.string(from: date)])
        print(mixpanel.currentSuperProperties());

    }
    
    
    let mixpanel = Mixpanel.sharedInstance()
    
   
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //get IDFA
    
    let myIDFA: String?
    //check if advertising tracking is enabled
    if ASIdentifierManager.shared().isAdvertisingTrackingEnabled{
        //set the idfa
        myIDFA = ASIdentifierManager.shared().advertisingIdentifier.uuidString
    } else {
        myIDFA = nil
    }
    
    mixpanel.identify(myIDFA!)
    
    mixpanel.track("Buying Page", properties: ["prop":"Loaded Buying Page"])
    
    
    getDate()
    
    
    
    title = "WingBoard"
    
    refreshControl = UIRefreshControl()
    refreshControl?.addTarget(self, action: #selector(MasterViewController.reload), for: .valueChanged)
    
    let restoreButton = UIBarButtonItem(title: "Restore", style: .plain, target: self, action: #selector(MasterViewController.restoreTapped(_:)))
    navigationItem.rightBarButtonItem = restoreButton
    
    NotificationCenter.default.addObserver(self, selector: #selector(MasterViewController.handlePurchaseNotification(_:)),
                                                               name: NSNotification.Name(rawValue: IAPHelper.IAPHelperPurchaseNotification),
                                                             object: nil)
  }
    
    
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    reload()
  }
  
  func reload() {
    products = []
    
    tableView.reloadData()
    
    RageProducts.store.requestProducts{success, products in
      if success {
        self.products = products!
        
        self.tableView.reloadData()
      }
      
      self.refreshControl?.endRefreshing()
    }
  }
  
  func restoreTapped(_ sender: AnyObject) {
    RageProducts.store.restorePurchases()
  }

  func handlePurchaseNotification(_ notification: Notification) {
    guard let productID = notification.object as? String else { return }
    
    for (index, product) in products.enumerated() {
      guard product.productIdentifier == productID else { continue }
      
      tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
    }
  }
}

// MARK: - UITableViewDataSource

extension MasterViewController {
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Go To Setup, General, Keyboard, Keyboards, Add New, WingBoard, Select and Allow Full Access"
    }
    
   override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let title = UILabel()
        title.font = UIFont(name: "Futura", size: 38)!
        title.textColor = UIColor.lightGray
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font=title.font
        header.textLabel?.textColor=title.textColor
        //        header.textLabel?.textAlignment = NSTextAlignmentCenter
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return products.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProductCell
    
    let product = products[indexPath.row]
    
    cell.product = product
    cell.buyButtonHandler = { product in
      RageProducts.store.buyProduct(product)
        
        let mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("Buying Page", properties: ["prop":"Clicked Cell"])
        
    
    }
    
    cell.layer.borderColor = UIColor.lightGray.cgColor
    cell.layer.borderWidth = 1
    cell.layer.cornerRadius = 8
    
    return cell
  }
}



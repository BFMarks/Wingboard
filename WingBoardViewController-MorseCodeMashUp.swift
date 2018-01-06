///////AlamoFire
////////////////https://www.appcoda.com/alamofire-beginner-guide/
////////
////////Get Keyboard Framework
////////////////https://www.weheartswift.com/make-custom-keyboard-ios-8-using-swift/
/////
////////Set TableView
/////////http://viperxgames.blogspot.com/2014/11/add-uitableview-programmatically-in.html
/////
////////Set Print Console for keyboard extension
/////////http://stackoverflow.com/questions/24480462/print-to-console-from-application-extension
/////
////////Make sure Keyboard can access internet
//////http://stackoverflow.com/questions/25796041/the-connection-to-service-named-com-apple-nsurlstorage-cache-was-invalidated
////
////////Async
////////////http://stackoverflow.com/questions/27390656/how-to-return-value-from-alamofire
////////🌐🍻🍆🔥💍🐣

import UIKit
import Alamofire



class KeyboardViewController: UIInputViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView  =   UITableView()
    //other setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ////JSON
        getJSONFromServer()
        print("view fudking loaded")
        
        tableView.frame         =   CGRectMake(0, 50, 320, 200);
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        ////Put that interface above tableview
        view.addSubview(customInterface)
        addKeyboardButtons()
        self.view.addSubview(tableView)
        
        
    }
    
    var jsonArray:NSMutableArray?
    var newArray: Array<String> = []
    
    
    func getJSONFromServer() {
        Alamofire.request(.GET, "https://wingboard.herokuapp.com/general") .responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                self.jsonArray = JSON as? NSMutableArray
                for item in self.jsonArray! {
                    let string = item["generalText"]!
                    print("String is \(string!)")
                    self.newArray.append(string! as! String)
                }
                
                print("The current value of self.jsonArray is \(self.jsonArray)")
                print("The current value of JSON is \(JSON)")
                print("The current value of SELF.NEWARRAY is \( self.newArray)")
                self.tableView.reloadData()
                
            }
        }
    }
    
    
    //delegate&datasource methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.numberOfLines=0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        cell.textLabel?.text = self.newArray[indexPath.row]
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        let proxy = textDocumentProxy as UITextDocumentProxy
        let text = self.newArray[indexPath.row]
        proxy.insertText(text)
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    //        var nextView: UIButton!
    var nextKeyboardButton: UIButton!
    var deleteButton: UIButton!
    var hideKeyboardButton: UIButton!
    
    var customInterface: UIView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        let nib = UINib(nibName: "CustomKeyBoard", bundle: nil)
        let objects = nib.instantiateWithOwner(self, options: nil)
        customInterface = objects[0] as! UIView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        // Add custom view sizing constraints here
    }
    
    
    
    func addKeyboardButtons() {
        print("Add Keyboard")
        addNextKeyboardButton()
        addDelete()
        
    }
    
    func addNextKeyboardButton() {
        nextKeyboardButton = UIButton(type: .System) as UIButton
        
        nextKeyboardButton.setTitle(NSLocalizedString("🌐", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        nextKeyboardButton.sizeToFit()
        nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        nextKeyboardButton.addTarget(self, action: #selector(UIInputViewController.advanceToNextInputMode), forControlEvents: .TouchUpInside)
        
        view.addSubview(nextKeyboardButton)
        
        
        let nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: nextKeyboardButton, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: -65.0)
        let nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item:nextKeyboardButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: +10.0)
        view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
    }
    
    
    func addDelete() {
        deleteButton = UIButton(type: .System) as UIButton
        deleteButton.setTitle(" Delete ", forState: .Normal)
        deleteButton.sizeToFit()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.addTarget(self, action: "didTapDelete", forControlEvents: .TouchUpInside)
        
        deleteButton.backgroundColor = UIColor(white: 0.9, alpha: 1)
        deleteButton.layer.cornerRadius = 5
        
        view.addSubview(deleteButton)
        
        let rightSideConstraint = NSLayoutConstraint(item: deleteButton, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: -10.0)
        let topConstraint = NSLayoutConstraint(item: deleteButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: +10.0)
        view.addConstraints([rightSideConstraint, topConstraint])
    }
    
    func didTapDelete() {
        
        let proxy = textDocumentProxy as UITextDocumentProxy
        
        proxy.deleteBackward()
    }
    
    @IBAction func didTapForDrinking() {
        
        //         API().apiEndPoint
        
        
        
        clearTable()
        //        print("***The current value of newArray is \(self.newArray)")
        Alamofire.request(.GET, "https://wingboard.herokuapp.com/drinking") .responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                self.jsonArray = JSON as? NSMutableArray
                for item in self.jsonArray! {
                    let string = item["generalText"]!
                    print("String is \(string!)")
                    self.newArray.append(string! as! String)
                }
                
                print("The current value of self.jsonArray is \(self.jsonArray)")
                print("The current value of JSON is \(JSON)")
                print("The current value of SELF.NEWARRAY is \( self.newArray)")
                self.tableView.reloadData()
                
            }
        }
    }
    
    func clearTable() {
        self.newArray.removeAll()
        self.tableView.reloadData()
        return
    }
    
    
    @IBAction func didTapWeheartSwift() {
        clearTable()
        //            print("API().apiEndPoint is*&^ \(API().apiEndPoint)")
        
        let api = API()
        api.getOrders() { responseObject, error in
            // use responseObject and error here
            
            print("responseObject = \(responseObject); error = \(error)")
            
            if let JSON = responseObject {
                self.jsonArray = JSON as? NSMutableArray
                for item in self.jsonArray! {
                    let string = item["generalText"]!
                    print("String is \(string!)")
                    self.newArray.append(string! as! String)
                }
                
                print("The current value of self.jsonArray is \(self.jsonArray)")
                print("The current value of JSON is \(JSON)")
                print("The current value of SELF.NEWARRAY is \( self.newArray)")
                self.tableView.reloadData()
                
                return
            }
        }
        
    }
    
    @IBAction func didTapForCuddling() {
        clearTable()
        
        Alamofire.request(.GET, "https://wingboard.herokuapp.com/cuddling") .responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                self.jsonArray = JSON as? NSMutableArray
                for item in self.jsonArray! {
                    let string = item["generalText"]!
                    print("String is \(string!)")
                    self.newArray.append(string! as! String)
                }
                
                print("The current value of self.jsonArray is \(self.jsonArray)")
                print("The current value of JSON is \(JSON)")
                print("The current value of SELF.NEWARRAY is \( self.newArray)")
                self.tableView.reloadData()
                
            }
        }
    }
    
    @IBAction func didTapForPassion() {
        clearTable()
        Alamofire.request(.GET, "https://wingboard.herokuapp.com/passion") .responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                self.jsonArray = JSON as? NSMutableArray
                for item in self.jsonArray! {
                    let string = item["generalText"]!
                    print("String is \(string!)")
                    self.newArray.append(string! as! String)
                }
                
                print("The current value of self.jsonArray is \(self.jsonArray)")
                print("The current value of JSON is \(JSON)")
                print("The current value of SELF.NEWARRAY is \( self.newArray)")
                self.tableView.reloadData()
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        var textColor: UIColor
        let proxy = textDocumentProxy as UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }
    
    /////GET JSON DATA
    
    
    
}






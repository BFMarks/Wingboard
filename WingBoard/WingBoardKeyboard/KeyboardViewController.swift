
//  TableViewCell.swift
//  Wing Board
//
//  Created by Bryan Marks on 8/3/16.
//  Copyright © 2016 Bryan Marks. All rights reserved.
//

import UIKit
import Alamofire
import AppsFlyerTracker

//let token = "xxx"
//let mixpanel = Mixpanel.sharedInstanceWithToken(token)

open class KeyboardViewController: UIInputViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    
    var tableView: UITableView  =   UITableView()
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(customInterface)
        view.backgroundColor = UIColor.white
        addKeyboardButtons()
        view.addSubview(tableView)
//        self.view.addSubview(tableView)
//        getChecoPI()
//        didTapforNewLines() 
//        getGeneralFromServer()

        
//        let viewC = ViewController()
    }
    
    override open func viewDidLayoutSubviews() {
        createCollectionView()
        let tableViewWidth = view.bounds.size.width
        let tableViewHeight = view.bounds.size.height
        tableView.frame         =   CGRect(x: 0, y: 50, width: tableViewWidth, height: tableViewHeight - 50);
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  //      self.view.addSubview(tableView)

    }
    
    
    var jsonArray:NSMutableArray?
    var newArray: Array<String> = ["*Make sure to allow access in settings!*", "If you were a vegetable, you would be a cute-cumber", "Of all your great curves, your smile is my favourite", "Can I follow you? Cause my mom told me to follow my dreams", "Roses are red, violets are blue, lava is hot and so are you", ]
    var newHeader:[String] = ["Connect to the internet to get more!"]
    var categoriesArray:NSMutableArray?
    
    //delegate&datasource methods
   open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newArray.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        cell.textLabel?.numberOfLines=0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.font = UIFont(name:"Avenir", size:17)
        
        cell.textLabel?.text = self.newArray[indexPath.row]
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.1
        cell.layer.cornerRadius = 10
        
        
        return cell
        
    }
    
   open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        let proxy = textDocumentProxy as UITextDocumentProxy
        let text = self.newArray[indexPath.row]
        proxy.insertText(text)
//        mixpanel.track("Line Used", properties: ["Line Used": text])
    }
    
    
   open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    

    
  open  func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
   open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.newHeader[0]
    }
    
  open  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let title = UILabel()
        title.font = UIFont(name: "Avenir", size: 19)!
        title.textColor = UIColor.lightGray
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font=title.font
        header.textLabel?.textColor=title.textColor
        //        header.textLabel?.textAlignment = NSTextAlignmentCenter
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    open func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.insert) {
            // handle delete (by removing the data from your array and updating the tableview)
            print("did edit table")
        }
    }
    
    open func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let more = UITableViewRowAction(style: .normal, title: "Lame") { action, index in
            print("more button tapped")
            
            
        }
        more.backgroundColor = UIColor.lightGray
        
        let favorite = UITableViewRowAction(style: .normal, title: "Fuego") { action, index in
            print("favorite button tapped")
        }
        favorite.backgroundColor = UIColor.red
        
        let share = UITableViewRowAction(style: .normal, title: "Got # ;)") { action, index in
            print("share button tapped")
        }
        share.backgroundColor = UIColor.green
        
        return [share, favorite, more]
    }
    
    open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    var collectionView: UICollectionView!
    
   open func createCollectionView() {
    
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 28, height: 28)
        layout.scrollDirection = .horizontal
        
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 220, height: 50), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor.white
    
        view.addSubview(collectionView)
        self.collectionView.layer.zPosition = 101
        
        
        //Added ViewConstraints
        
    }
    
    
    
   open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picture.count
//    return chechoCategories.count
    
    }
    
    
    ////////Working//////
  open  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.white
        

        let imageView:UIImageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        imageView.image = picture[indexPath.row]
        //add curvers
//        cell.layer.borderWidth = 1.5
//        cell.layer.borderColor = UIColor.whiteColor().CGColor
//        cell.layer.cornerRadius = 4
        cell.addSubview(imageView)
        return cell
    }
    
    var chechoPILinesDictionary:NSDictionary?
 
    var picture:[UIImage] = [
        UIImage(named: "generalImage.png")!,
         UIImage(named: "JustForGirls.png")!,
          UIImage(named: "userSubmittedImage.png")!,
           UIImage(named: "passionImage.png")!,
            UIImage(named: "otherTeam.png")!,
             UIImage(named: "cuddlingImage.png")!,
              UIImage(named: "drinkingImage.png")!,
              UIImage(named: "KeyboardIcon.png")!,
             ]

    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let cell : UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        cell.backgroundColor = UIColor.white
        print("You selected cell #\(indexPath.row)!")
        
//        for item in idArray {
//        }
        
        
//        for item in idArray{
//            print(item)
//            let api = LineController()
//            api.getOrders(item) { responseObject, error in
//             // use responseObject and error here
//                
//  //            print("responseObject = \(responseObject); error = \(error)")
//                if let JSON = responseObject {
//                    print("JSON = \(JSON); error = \(error)")
//                    self.clearTable()
//                    self.newHeader[0] = "TEST"
//                    self.chechoPILinesDictionary = NSDictionary(dictionary: JSON as! NSDictionary)
//                    print("self.chechoPILinesDictionary = \(self.chechoPILinesDictionary)")
//                    for (key, value) in self.chechoPILinesDictionary! {
//                        print("key is \(key)")
//                        print("value is \(value)")
////                        let string = item["body"]!
////                        print("String is \(string!)")
////                        self.newArray.append(string! as! String)
//                    }
//                    self.tableView.reloadData()
//                }
////                print("Item[0] = \(item[0])")
//            }
//
//        }
/////////CHECHOPI
        if(0 == indexPath.row){
            addTableView()
            didTapforNewLines()
//            mixpanel.track("Category Selected",
//                           properties: ["Category Type": "General"])
            
        } else if(1 == indexPath.row){
            addTableView()
            didTapForBestOfLines()
            
//            mixpanel.track("Category Selected",
//                           properties: ["Category Type": "BestOf"])

            
        } else if(2 == indexPath.row){
            addTableView()
            didTapForUserSubmission()
            
//            mixpanel.track("Category Selected",
//                           properties: ["Category Type": "User Submission"])
            
        } else if(3 == indexPath.row){
            addTableView()
            didTapForPassion()
            
//            mixpanel.track("Category Selected",
//                           properties: ["Category Type": "Passion"])
            
        } else if(4 == indexPath.row){
            addTableView()
            didTapForOtherTeam()
            
//            mixpanel.track("Category Selected",
//                           properties: ["Category Type": "Queer Friendly"])
            
        } else if(5 == indexPath.row){
            addTableView()
            didTapForCuddling()
            
//            mixpanel.track("Category Selected",
//                           properties: ["Category Type": "Cuddling"])
            
        } else if(6 == indexPath.row){
            
//            removeActualKeyboard()
            addTableView()
            
            didTapForDrinking()
            
//            mixpanel.track("Category Selected",
//                           properties: ["Category Type": "Drinking Lines"])
            
        }
        else if(7 == indexPath.row){
//            self.view.sendSubviewToBack(tableView)
//            self.view.bringSubviewToFront(customInterface)
//             self.view.willRemoveSubview(tableView)
            view.bringSubview(toFront: customInterface)
            view.addSubview(nextKeyboardButton)
            view.addSubview(deleteButton)
            
            
            self.customInterface.layer.zPosition = 100
            customInterface.center = self.view.center
            
//            mixpanel.track("Category Selected",
//                           properties: ["Category Type": "Actual Keyboard"])
        }
    }
    
    func addTableView() {
//        view.sendSubviewToBack(customInterface)
        view.bringSubview(toFront: tableView)
        self.customInterface.layer.zPosition = 0
    }
    
    func removeTableView() {
        view.sendSubview(toBack: tableView)
        view.bringSubview(toFront: customInterface)
        self.tableView.layer.zPosition = 0
    }
    
    func removeActualKeyboard() {
        for view in customInterface.subviews{
            view.removeFromSuperview()
        }
    }
    func removeActualTableView() {
        for view in tableView.subviews{
            view.removeFromSuperview()
        }
    }
    
    func getGeneralFromServer() {
        self.newHeader[0] = "Get Internet for new Lines!"
        let api = API()
        let variableString: String = "general"
        api.getOrders(variableString) { responseObject, error in
            // use responseObject and error here
            
//            print("responseObject = \(responseObject); error = \(error)")
            if let JSON = responseObject {
                self.clearTable()
                self.newHeader[0] = "New"
                self.jsonArray = NSMutableArray(array: JSON as! NSArray)
                for item in JSON as! [AnyObject] {
                    let string = item["generalText"]!
                    print("String is \(string!)")
                    self.newArray.append(string! as! String)
                }
                self.tableView.reloadData()
            }  else if error != nil {
                self.newHeader[0] = "New Lines (No Internet)"
                self.newArray.append(contentsOf: ["*Make sure to allow access in settings!*", "If you were a vegetable, you would be a cute-cumber", "Of all your great curves, your smile is my favourite", "Can I follow you? Cause my mom told me to follow my dreams", "Roses are red, violets are blue, lava is hot and so are you", ])
        }
//            mixpanel.track("Ended JSON")
        }
    }
    
    func didTapForUserSubmission() {
        clearTable()
        self.newHeader[0] = "User Submitted"
        let api = API()
        let variableString: String = "usersubmission"
        api.getOrders(variableString) { responseObject, error in
            print("responseObject = \(responseObject); error = \(error)")
            if let JSON = responseObject {
                print("JSON is \(JSON)")
                let found = JSON["found"] as? [AnyObject]
                print("found is \(found)")
                for item in found! {
                    let string = item["generalText"]!
                    print("String is \(string!)")
                    self.newArray.append(string! as! String)
                }
                self.tableView.reloadData()
            }  else if error != nil {
                self.newHeader[0] = "User Submitted (No Internet)"
                self.newArray.append(contentsOf: ["*Make sure to allow access in settings!*", "If you were a vegetable, you would be a cute-cumber", "Of all your great curves, your smile is my favourite", "Can I follow you? Cause my mom told me to follow my dreams", "Roses are red, violets are blue, lava is hot and so are you", ])
            }
        }
    }
    
      func didTapforNewLines() {
//        mixpanel.track("Ended JSON")
        clearTable()
         //GET CATEGORY NAME
        self.newHeader[0] = "New"
        let api = API()
        let variableString: String = "general"
        api.getOrders(variableString) { responseObject, error in
            // use responseObject and error here
            
            print("responseObject = \(responseObject); error = \(String(describing: error))")
            if let JSON = responseObject {
                self.jsonArray = NSMutableArray(array: JSON as! NSArray)
                for item in JSON as! [AnyObject] {
                    let string = item["generalText"]!
                    print("String is \(string!)")
                    self.newArray.append(string! as! String)
                }
            } else if error != nil {
                self.newHeader[0] = "Find Internet for new Lines!"
                self.newArray.append(contentsOf: ["*Make sure to allow access in settings!*", "If you were a vegetable, you would be a cute-cumber", "Of all your great curves, your smile is my favourite", "Can I follow you? Cause my mom told me to follow my dreams", "Roses are red, violets are blue, lava is hot and so are you", ])
            }
            self.tableView.reloadData()
        }
    }
    
    
    
    func didTapForDrinking() {
        clearTable()
        self.newHeader[0] = "Drinking"
        let api = API()
        let variableString: String = "drinking"
        api.getOrders(variableString) { responseObject, error in
            // use responseObject and error here
            print("responseObject = \(responseObject); error = \(error)")
            if let JSON = responseObject {
                self.jsonArray = NSMutableArray(array: JSON as! NSArray)
                for item in JSON as! [AnyObject] {
                    let string = item["generalText"]!
                    print("String is \(string!)")
                    self.newArray.append(string! as! String)
                }
                } else if error != nil {
                self.newHeader[0] = "Driking (No Internet)"
                self.newArray.append(contentsOf: ["*Make sure to allow access in settings!*", "If you were a vegetable, you would be a cute-cumber", "Of all your great curves, your smile is my favourite", "Can I follow you? Cause my mom told me to follow my dreams", "Roses are red, violets are blue, lava is hot and so are you", ])
            }
                self.tableView.reloadData()
        }
    }
    
    func didTapForCuddling() {
        clearTable()
        self.newHeader[0] = "Cuddling"
        let api = API()
        let variableString: String = "cuddling"
        api.getOrders(variableString) { responseObject, error in
            print("responseObject = \(responseObject); error = \(error)")
            if let JSON = responseObject {
                self.jsonArray = NSMutableArray(array: JSON as! NSArray)
                for item in JSON as! [AnyObject] {
                    let string = item["generalText"]!
                    print("String is \(string!)")
                    self.newArray.append(string! as! String)
                }
            } else if error != nil {
                self.newHeader[0] = "Cuddling (No Internet)"
                self.newArray.append(contentsOf: ["*Make sure to allow access in settings!*", "If you were a vegetable, you would be a cute-cumber", "Of all your great curves, your smile is my favourite", "Can I follow you? Cause my mom told me to follow my dreams", "Roses are red, violets are blue, lava is hot and so are you", ])
            }
            self.tableView.reloadData()
        }
    }
    
    
    
    
    func didTapForPassion() {
        clearTable()
        self.newHeader[0] = "Passionaté"
        let api = API()
        let variableString: String = "passion"
        api.getOrders(variableString) { responseObject, error in
            print("responseObject = \(responseObject); error = \(error)")
            if let JSON = responseObject {
                self.jsonArray = NSMutableArray(array: JSON as! NSArray)
                for item in JSON as! [AnyObject] {
                    let string = item["generalText"]!
                    print("String is \(string!)")
                    self.newArray.append(string! as! String)
                }
            } else if error != nil {
                self.newHeader[0] = "Passionaté (No Internet)"
                self.newArray.append(contentsOf: ["*Make sure to allow access in settings!*", "If you were a vegetable, you would be a cute-cumber", "Of all your great curves, your smile is my favourite", "Can I follow you? Cause my mom told me to follow my dreams", "Roses are red, violets are blue, lava is hot and so are you", ])
            }
            self.tableView.reloadData()
        }
    }
    
    
   open func didTapForBestOfLines() {
        clearTable()
        self.newHeader[0] = "Just For Girls"
        let api = API()
        let variableString: String = "bestof"
        api.getOrders(variableString) { responseObject, error in
            print("responseObject = \(responseObject); error = \(error)")
            if let JSON = responseObject {
                self.jsonArray = NSMutableArray(array: JSON as! NSArray)
                for item in JSON as! [AnyObject] {
                    let string = item["generalText"]!
                    print("String is \(string!)")
                    self.newArray.append(string! as! String)
                }
            } else if error != nil {
                self.newHeader[0] = "Just For Girls (No Internet)"
                self.newArray.append(contentsOf: ["*Make sure to allow access in settings!*", "If you were a vegetable, you would be a cute-cumber", "Of all your great curves, your smile is my favourite", "Can I follow you? Cause my mom told me to follow my dreams", "Roses are red, violets are blue, lava is hot and so are you", ])
            }
            self.tableView.reloadData()
        }
    }
    
    func didTapForOtherTeam() {
        clearTable()
        self.newHeader[0] = "Queer Friendly"
        let api = API()
        let variableString: String = "otherteam"
        api.getOrders(variableString) { responseObject, error in
            print("responseObject = \(responseObject); error = \(error)")
            if let JSON = responseObject {
                self.jsonArray = NSMutableArray(array: JSON as! NSArray)
                for item in JSON as! [AnyObject] {
                    let string = item["generalText"]!
                    print("String is \(string!)")
                    self.newArray.append(string! as! String)
                }
            } else if error != nil {
                self.newHeader[0] = "Queer Friendly (No Internet)"
                self.newArray.append(contentsOf: ["*Make sure to allow access in settings!*", "If you were a vegetable, you would be a cute-cumber", "Of all your great curves, your smile is my favourite", "Can I follow you? Cause my mom told me to follow my dreams", "Roses are red, violets are blue, lava is hot and so are you", ])
            }
            self.tableView.reloadData()
        }
    }
    
    func clearTable() {
        self.newArray.removeAll()
        self.tableView.reloadData()
        return
    }
    
    func clearHeader() {
        self.newHeader.removeAll()
        return
    }
    
    
  open  override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
  open  override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
   open override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        var textColor: UIColor
        let proxy = textDocumentProxy as UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        nextKeyboardButton.setTitleColor(textColor, for: UIControlState())
    }
    
    var nextKeyboardButton: UIButton!
    var deleteButton: UIButton!
    var hideKeyboardButton: UIButton!
    
    var customInterface: UIView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        let nib = UINib(nibName: "CustomKeyBoard", bundle: nil)
        let objects = nib.instantiate(withOwner: self, options: nil)
        customInterface = objects[0] as! UIView
    }
    
   public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   open override func updateViewConstraints() {
        super.updateViewConstraints()
        // Add custom view sizing constraints here
    }
    
    
    
    func addKeyboardButtons() {
        print("Add Keyboard")
        
        addNextKeyboardButton()
        addDelete()
        
    }
    
    func addNextKeyboardButton() {
        
        nextKeyboardButton = UIButton(type: .system) as UIButton
        
        nextKeyboardButton.setTitle(NSLocalizedString("🌐", comment: "Title for 'Next Keyboard' button"), for: UIControlState())
        nextKeyboardButton.sizeToFit()
        nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        nextKeyboardButton.addTarget(self, action: #selector(UIInputViewController.advanceToNextInputMode), for: .touchUpInside)
        
        view.addSubview(nextKeyboardButton)
        
        
        let nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: nextKeyboardButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -65.0)
        let nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item:nextKeyboardButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: +10.0)
        view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
        self.nextKeyboardButton.layer.zPosition = 101
    }
    
    
    func addDelete() {
        deleteButton = UIButton(type: .system) as UIButton
        deleteButton.setTitle(" Delete ", for: UIControlState())
        deleteButton.sizeToFit()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.addTarget(self, action: #selector(KeyboardViewController.didTapDelete), for: .touchUpInside)
        
        deleteButton.backgroundColor = UIColor(white: 0.9, alpha: 1)
        deleteButton.layer.cornerRadius = 5
        
        view.addSubview(deleteButton)
        
        let rightSideConstraint = NSLayoutConstraint(item: deleteButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -10.0)
        let topConstraint = NSLayoutConstraint(item: deleteButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: +10.0)
        view.addConstraints([rightSideConstraint, topConstraint])
        self.deleteButton.layer.zPosition = 101
    }
    
    
    func didTapDelete() {
        
        let proxy = textDocumentProxy as UITextDocumentProxy
        
        proxy.deleteBackward()
    }
    
    //ROW ONE
    @IBAction func exclamationButton(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("1")
        print("tapped !")
    }
    @IBAction func button2(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("2")
    }
    @IBAction func button3(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("3")
    }
    @IBAction func button4(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("4")
    }
    @IBAction func button5(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("5")
    }
    @IBAction func button6(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("6")
    }
    @IBAction func button7(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("7")
    }
    @IBAction func button8(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("8")
    }
    @IBAction func button9(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("9")
    }
    @IBAction func button0(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("0")
    }
    //ROW TWO
    @IBAction func buttonE(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("e")
    }
    @IBAction func buttonR(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("r")
    }
    @IBAction func buttonT(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("t")
    }
    @IBAction func buttonY(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("y")
    }
    @IBAction func buttonU(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("u")
    }
    @IBAction func buttonI(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("i")
    }
    @IBAction func buttonO(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("o")
    }
    @IBAction func buttonP(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("p")
    }
    @IBAction func buttonQ(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("q")
    }
    @IBAction func buttonW(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("w")
    }
    //ROW 3
    @IBAction func buttonA(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("a")
    }
    @IBAction func buttonS(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("s")
    }
    @IBAction func buttonD(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("d")
    }
    @IBAction func buttonF(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("f")
    }
    @IBAction func buttonG(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("g")
    }
    @IBAction func buttonH(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("h")
    }
    @IBAction func buttonJ(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("j")
    }
    @IBAction func buttonK(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("k")
    }
    @IBAction func buttonL(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("l")
    }
    @IBAction func buttonDash(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("-")
    }
    @IBAction func buttonZ(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("z")
    }
    @IBAction func buttonX(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("x")
    }
    @IBAction func buttonC(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("c")
    }
    @IBAction func buttonV(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("v")
    }
    @IBAction func buttonB(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("b")
    }
    @IBAction func buttonN(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("n")
    }
    @IBAction func buttonM(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("m")
    }
    @IBAction func buttonComma(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText(",")
    }
    @IBAction func buttonPeriod(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText(".")
    }
    @IBAction func buttonSlash(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("/")
    }
    
    @IBAction func buttonSpace(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText(" ")
    }
    
    @IBAction func buttonClearAll(_ sender: AnyObject) {
        print("clear")
    }
    @IBAction func wingButt(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UIKeyInput
        proxy.insertText("WingBoard")
    }
    
    
    ///////CHECHO
//    var chechoCategories: [WingboardCategory] = []
//    var chechoArray: Array<String> = []
//    var idArray: Array<Int> = []
//    
//    func getChecoPI(){
//        print("Getting CHECHOPI")
//        self.newHeader[0] = "Getting from ChechoPI!"
//        let api = ChechoPI()
//        let variableString: String = "api/categories/"
//        api.getOrders(variableString) { responseObject, error in
//            
//            
//            print("responseObject*** = \(responseObject);")
//            if let JSON = responseObject {
//                print("JSON*** = \(JSON);")
//                let category = JSON["result"] as? [AnyObject]
//                for item in category! {
//                    //                    print("item[name]**$RR is \(item["name"])")
//                    
//                    let name = item["name"]!
//                    let id = item["id"]!
//                    
//                    //                    let wingboardCategory = WingboardCategory()
//                    
//                    
//                    //                    let newCategory = WingboardCategory.init(name: name, id: id)
//                    //                      print("The id of WingboardCategory is \(wingboardCategory.id)")
//                    self.chechoArray.append(name! as! String)
//                    self.idArray.append(id! as! Int)
//                    
//                    
//                }
//                print("chechoArray*** = \(self.chechoArray);")
//                print("idArray*** = \(self.idArray);")
//                func getLines(){
//                    print("Getting Checho lines")
//                    
//                    
//                }
//                //            } else if error != nil {
//                
//            }
//            
//        }
//        
//    }
//    
    //     let newCategory = WingboardCategory.init(name: item["name"], id: item["id"])
    
}



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





    

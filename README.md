# Wingboard

A keyboard app that recommends pickup lines and sweet things to say to your significant other!  


<a href="url"><img src="https://www.evernote.com/shard/s689/sh/96b977d8-8170-42f1-88bb-264a8ce26493/32f2bfe816a3816a/res/b5a3d900-54d8-4601-81bd-5d8bf72fa0d1/skitch.png?resizeSmall&width=210" align="left" height="72" width="72" ></a>


------

Basic tutorial included but happy to add more if there are enough requested!

## Live DEMO

![alt text](https://github.com/BFMarks/Wingboard/blob/master/testdemo.gif)


## These are the SDK's in the project.

 - [Mixpanel](https://github.com/mixpanel)
 - [AppsFlyer](https://github.com/AppsFlyerSDK/)

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/https://www.paypal.me/bfmarks)
Donations will be put back in tutorials (but please don't feel like it's necessary).

## Installation

*This code is unfortunately a little messy and I haven't time to refactor it :( It's one of the first App's I built so will require some fixes to operate.

### Install the SDK's by opening terminal to root directory of your project.

    pod install

### Open the Xcode Workspace (not the project)

    Wingboard.xcworkspace



## [KeyboardViewController](https://github.com/BFMarks/Wingboard/blob/master/WingBoard/WingBoardKeyboard/KeyboardViewController.swift)


![alt text](https://github.com/BFMarks/Wingboard/blob/master/screenshot2.jpg)

### Swift

This is the main heart of the keyboard.  It has a collection view for the different categories and a tableview for each line, all done programmatically.    

```swift
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
    }
    
   open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picture.count
    }
    
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
    
```
This function sets the number of cells in the Collection View.   It is typically set to the ```.count``` of the number of items in the array that holds the data for each cell.  The TableView is repopulated based on the index of the collection view.  The collection view is hard coded to the server (not best practice).  


```swift
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {        
        let cell : UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        cell.backgroundColor = UIColor.white
        print("You selected cell #\(indexPath.row)!")
 
        if(0 == indexPath.row){
            addTableView()
            didTapforNewLines()
            mixpanel.track("Category Selected",
                           properties: ["Category Type": "General"])
            
        } else if(1 == indexPath.row){
            addTableView()
            didTapForBestOfLines()
            mixpanel.track("Category Selected",
                           properties: ["Category Type": "BestOf"])
            
        }
    
```
This function displays the data in each cell.  You must have a separate class to contain the cell data, which in this project is ```TableViewCell.swift```.

Lastly, we have the function that plays the video:

```swift
 private  func playVideo(video: String) {
        guard let path = Bundle.main.path(forResource: video, ofType:"m4v") else {
            debugPrint("video.m4v not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    }
```
The videos in the array are then called with this function: ```playVideo(video: movArray[indexPath.row])```, where movArray is the array holding all of the videos.  Typically, you would get all of the video data from the server but this is simply an example app.

This is has been a brief tutorial on how to setup a table View in iOS Swift.  Please feel free to ask questions on how the app is build and I will add tutorial points later if needed.

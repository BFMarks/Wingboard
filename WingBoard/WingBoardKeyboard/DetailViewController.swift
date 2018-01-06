

//import WingBoardKeyboard
import UIKit

let mySpecialNotificationKey = "com.andrewcbancroft.specialNotificationKey"

class DetailViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView?
    
    @IBOutlet weak var sentNotificationLabel: UILabel!

  
  var image: UIImage? {
    didSet {
      configureView()
    }
  }
  
    @IBAction func unlockBestOf(_ sender: AnyObject) {
        
//        NSNotificationCenter.defaultCenter().postNotificationName(mySpecialNotificationKey, object: self)
        
//        let key = KeyboardViewController()
        
        
        
    }
    
//    func updateNotificationSentLabel() {
//        self.sentNotificationLabel.text = "Notification sent!"
//    }
    
        
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "WingBoardLogo.png")
        imageView.image = image
        navigationItem.titleView = imageView
    }
  
  
  
  func configureView() {
    imageView?.image = image
  }
}

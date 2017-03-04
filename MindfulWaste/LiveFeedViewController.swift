import UIKit

class LiveFeedViewController: UIViewController
{
    
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func showHomeScreen(_ sender: AnyObject) {
        
        sideMenuController?.performSegue(withIdentifier: "showCenterController1", sender: self)
        
    }
    
    
    
}

import UIKit
import SideMenuController

class HomePageViewController : UIViewController, SideMenuControllerDelegate
{
    
    override func viewDidLoad() {
        sideMenuController?.delegate = self
    }
    
    public func sideMenuControllerDidHide(_ sideMenuController: SideMenuController) {
        print(#function)
        
    }
    
    func sideMenuControllerDidReveal(_ sideMenuController: SideMenuController) {
        print(#function)
    }
    
    
}

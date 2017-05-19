import UIKit
import expanding_collection

class OrganizationDetailTableViewController : ExpandingTableViewController
{
    
    override func viewDidLoad()
    {
        navigationItem.hidesBackButton = true
        
    }

    
    @IBAction func removeCurrentVC(_ sender: Any) {
        self.popTransitionAnimation()
    }
}

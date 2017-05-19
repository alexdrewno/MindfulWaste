import UIKit
import FirebaseAuth
import FirebaseDatabase

class AllOrganizationViewController : UITableViewController
{
    
    override func viewDidLoad() {
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newOrganizationCell")
        cell?.selectionStyle = .none
//        switch indexPath.row
//        {
//        case 0:
//        
//        default:
//            break
//        }
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 343
    }
    
    @IBAction func newOrganization(_ sender: Any) {
        
        let alertVC = UIAlertController(title: "New Organization", message: "What do you want to name your organization?", preferredStyle: .alert)
        alertVC.addTextField { (textField) in
            textField.placeholder = "Organization Name"
        }
        
        alertVC.addTextField { (textField) in
            textField.placeholder = "Confirm Name"
        }
    
        alertVC.addAction(UIAlertAction(title: "Done", style: .default, handler: { (alertAction) in
            if Auth.auth().currentUser != nil
            {
                let ref = Database.database().reference(withPath: "organizations")
                
            }
        }))
        
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
            
        }))
        
        present(alertVC, animated: false, completion: nil)
        
        
        
    }
}

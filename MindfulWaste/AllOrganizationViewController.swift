import UIKit
import FirebaseAuth
import FirebaseDatabase

class AllOrganizationViewController : UITableViewController
{
    
    var organizationArray = [String]()
    var tappedOrganization = ""
    
    override func viewDidLoad() {
        
        if let email = Auth.auth().currentUser?.email
        {
            let ref = Database.database().reference()
            
            ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
                for child in snapshot.children
                {
                    let dict = (child as! DataSnapshot).value as! NSDictionary
                    if let email2 = dict["email"] as? String
                    {
                        if email2 == email
                        {
                            let dict2 = ((child as! DataSnapshot).value as! NSDictionary)
                            self.organizationArray = dict2["organization"] as! Array
                            self.tableView.reloadData()
                            
                        }
                    }
                }
            }){ (error) in
                print(error.localizedDescription)
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(organizationArray)
        
        if organizationArray.count <= 1
        {
            print("ORGARRAY")
            let cell = tableView.dequeueReusableCell(withIdentifier: "newOrganizationCell")
            cell?.selectionStyle = .none
            return cell!
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "organizationCell")! as! OrganizationNameCell
            cell.selectionStyle = .none
            cell.organizationName.text! = organizationArray[indexPath.row+1]
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if organizationArray.count == 1
        {
            return 1
        }
        else
        {
            return organizationArray.count-1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if organizationArray.count == 1
        {
            return 343
        }
        else
        {
            return 175
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tappedOrganization = organizationArray[indexPath.row+1]
        performSegue(withIdentifier: "presentOrgView", sender: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentOrgView"
        {
            let dvc = segue.destination as! OrganizationDetailViewController
            dvc.orgNameText = tappedOrganization
        }
    }
}

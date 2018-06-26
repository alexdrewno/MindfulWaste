import UIKit
import Firebase

class OrganizationsTableViewController: UITableViewController
{
    
    var dictArray = [NSDictionary]()
    var org : NSDictionary!
    
    override func viewDidLoad() {
        let ref = Database.database().reference()
        
        navigationItem.title? = "All Organizations"
        
        ref.child("organizations").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children
            {
                let dict = (child as! DataSnapshot).value as! NSDictionary
                self.dictArray.append(dict)
                self.tableView.reloadData()
            }
        }){ (error) in
            print(error.localizedDescription)
        }

        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "organizationCell") as! OrganizationNameCell
        cell.organizationName.text! = dictArray[indexPath.row]["orgName"] as! String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        org = dictArray[indexPath.row]
        performSegue(withIdentifier: "showDetailOrg", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailOrg"
        {
            let dvc = segue.destination as! OrganizationDetailViewController
            dvc.orgNameText = org["orgName"] as! String
        }
    }
}

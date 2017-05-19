import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var organizationName: UILabel!
    var defaults = UserDefaults()
    
    override func viewDidLoad()
    {
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.delegate = self
        
        if let email = Auth.auth().currentUser?.email
        {
            print("stage1")
            let ref = Database.database().reference(withPath: "users")
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                print("stage2")
                for child in snapshot.children
                {
                    print("stage3")
                    let dict = (child as! DataSnapshot).value as! NSDictionary
                    if let email2 = dict["email"] as? String
                    {
                        if email2 == email
                        {
                            self.defaults.setValue(child as! NSDictionary, forKey: "user")
                            print(self.defaults.value(forKey: "user"))
                        }
                    }
                }
            })
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homePageCell")! as! HomePageCell
        cell.insideView.cornerRadius = 6
       
        
        switch indexPath.row{
            
        case 0:
            cell.labelName.text! = "My Reports"
            cell.imageViewIcon.image = UIImage(named: "newreporticon")
            cell.selectionStyle = .none
            

        case 1:
            cell.labelName.text! = "My Organization"
            cell.imageViewIcon.image = UIImage(named: "buildingimg")
            cell.selectionStyle = .none

        case 2:
            cell.labelName.text! = "Organizations"
            cell.imageViewIcon.image = UIImage(named: "multiusericon")
            cell.selectionStyle = .none


        default:
            break
        }
        return cell
    }
    @IBAction func newReportButton(_ sender: Any) {
        
        sideMenuController?.performSegue(withIdentifier: "newReport", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRow")
        switch indexPath.row{
        
        case 0:
            print("my reports")
            sideMenuController!.performSegue(withIdentifier: "organizationViewController", sender: nil)
        case 1:
            print("my organization")
        case 2:
            print("organizations")
            sideMenuController!.performSegue(withIdentifier: "organizationViewController", sender: nil)
            
        default:
            break
        }
    }
    
    
//    case 0:
//    cell.cellLabel.text = "New Report"
//    cell.imageIcon.image = UIImage(named: "newreporticon")
//    case 1:
//    cell.cellLabel.text = "My Reports"
//    cell.imageIcon.image = UIImage(named: "singleusericon")
//    case 2:
//    cell.cellLabel.text = "Organization(s)"
//    cell.imageIcon.image = UIImage(named: "multiusericon")
    

    
    
    
    
}

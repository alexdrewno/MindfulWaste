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
    let ref = Database.database().reference(withPath: "users")
    
    
    override func viewDidLoad()
    {
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.delegate = self
        self.navigationItem.hidesBackButton = true
        
        
        profileImage.image = UIImage(named: "singleusericon")
//        if let userDict = self.value(forKey: "user")
//        {
//            let userDict2 = userDict as! NSDictionary
//            let personName = "\(userDict2["firstName"] as! String) \(userDict2["lastName"] as! String)"
//            print(personName)
//        }
        
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
                            self.defaults.setValue("\(dict2["firstName"] as! String) \(dict2["lastName"] as! String)", forKey: "user")
                            self.personName.text! = self.defaults.value(forKey: "user") as! String
                            self.organizationName.text! = (dict2["organizations"] as! Array)[0] as! String
                            
                        }
                    }
                }
            }){ (error) in
                print(error.localizedDescription)
            }
        }

        
        
        print(self.defaults.value(forKey: "user"))
        personName.text! = self.defaults.value(forKey: "user") as! String
        
   

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
            sideMenuController!.performSegue(withIdentifier: "myOrganizationsSegue", sender: nil)
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

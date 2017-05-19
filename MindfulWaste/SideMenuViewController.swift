import UIKit
import SideMenuController
import FirebaseAuth

class SideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var tableView: UITableView!
    @IBOutlet var organizationNumber: UILabel!
    @IBOutlet var reportsNumberLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var personName: UILabel!
    
    /*
        
     1.) New Report
        -Create New Report
     
     2.) My Reports
        -List of self reported items and dates
     
     3.) Organization(s)
        -Create New Organization
        -Post on behalf of the Organization
        -List of organizations that the individual is a part of
            ->Each organization has a nice simple view of reports/total food saved/and admins of the organization
     
     */
    
    
    override func viewDidLoad()
    {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell") as! SideMenuCell
        cell.selectionStyle = .none
        
        switch indexPath.row{
            case 0:
                cell.cellLabel.text = "New Report"
                cell.imageIcon.image = UIImage(named: "newreporticon")
            case 1:
                cell.cellLabel.text = "My Reports"
                cell.imageIcon.image = UIImage(named: "singleusericon")
            case 2:
                cell.cellLabel.text = "Organization(s)"
                cell.imageIcon.image = UIImage(named: "multiusericon")
            default:
                break
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row
        {
            case 0:
                sideMenuController?.performSegue(withIdentifier: "newReport", sender: nil)
            default:
                break
        }
    }
}

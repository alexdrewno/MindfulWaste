import UIKit

class HomeViewController: UIViewController, UITableViewDataSource
{
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad()
    {
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
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
        case 1:
            cell.labelName.text! = "My Organization"
        case 2:
            cell.labelName.text! = "Organizations"
        default:
            break
        }
        return cell
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

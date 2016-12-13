import UIKit
import SideMenuController

class MenuController: UITableViewController {
    
    
    let array = ["Cell number 1", "Cell number 2", "Cell number 3"]
    override func viewDidLoad()
    {
        let imageView = UIImageView(image: UIImage(named: "greenGradient"))
        self.tableView.backgroundView = imageView
        tableView.separatorColor = UIColor.black
        tableView.tableFooterView = UIView(frame: CGRect.zero)

    }
    
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {

        if indexPath.row == 0 && indexPath.section == 0
        {
            let newCell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! CustomUserCell
            newCell.backgroundView?.alpha = 0.1
            return newCell
        }
        else
        {
            let cell : UITableViewCell = UITableViewCell()
            cell.textLabel!.text = array[indexPath.row]
            cell.textLabel?.textAlignment = .right
            cell.textLabel?.font = UIFont(name: "Cochin", size: 20)
            cell.backgroundView?.alpha = 0.1
            cell.backgroundColor = UIColor.clear
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0
        {
            (cell as! CustomUserCell).userImage.clipsToBounds = true
            (cell as! CustomUserCell).userImage.layer.cornerRadius = (cell as! CustomUserCell).userImage.frame.width/2
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 && indexPath.section == 0
        {
            return 200
        }
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }
        else
        {
            return 3
        }
    }
    
    
    
}

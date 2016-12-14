import UIKit
import SideMenuController

class MenuController: UITableViewController {
    
    enum Direction{ case In, Out }
    
    
    
    //reports, new report, organization(s)?
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

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        if indexPath.section == 0 && indexPath.row == 0
        {
            performSegue(withIdentifier: "showLogin", sender: nil)
            dim(direction: .In, alpha: 0.5, speed: 0.5)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLogin"
        {
            dim(direction: .In, alpha: 0.5, speed: 0.5)
            print("called")
        }
    }
    
    @IBAction func unwindFromSecondary()
    {
 
    }
    
    func dim(direction: Direction, alpha: CGFloat, speed: CGFloat)
    {
        let dimView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        dimView.backgroundColor = UIColor.gray
        dimView.alpha = 0.0
        switch direction{
            case .In:
                self.view.addSubview(dimView)
                dimView.alpha = 0.0
                UIView.animate(withDuration: TimeInterval(speed), animations: { 
                    dimView.alpha = alpha
                })
            case .Out:
                dimView.alpha = alpha
                UIView.animate(withDuration: TimeInterval(speed), animations: {
                    dimView.alpha = 0.0
                }, completion: { (bool:Bool) in
                    dimView.removeFromSuperview()
                })
            
        }
        
    }
    
    
}

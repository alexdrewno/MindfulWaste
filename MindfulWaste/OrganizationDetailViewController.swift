import UIKit
import Firebase
import FirebaseAuth

class OrganizationDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var orgName: UILabel!
    @IBOutlet weak var numReports: UILabel!
    @IBOutlet weak var descriptionInfo: UILabel!
    @IBOutlet weak var numUsers: UILabel!
    var organization : NSDictionary!
    var orgNameText = ""
    @IBOutlet weak var tableView: UITableView!
    var organizationArray = [String]()
    let defaults = UserDefaults()
    var reports = [NSDictionary]()
    var sendingDict : NSDictionary! = nil
    var first = false
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let ref = Database.database().reference(withPath: "organizations")
        let ref2 = Database.database().reference(withPath: "reports")
        
        ref2.observe(.value, with: { (snapshot) in
            for child in snapshot.children
            {
                let dict = (child as! DataSnapshot).value as! NSDictionary
                if (dict["organization"] as! String == self.orgNameText)
                {
                    self.reports.append(dict)
                }
            }
            
            var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            
            self.reports.sort(by: {dateFormatter.date(from: $0["date"] as! String)!.compare(dateFormatter.date(from: $1["date"] as! String)!) == .orderedDescending})
            self.tableView.reloadData()
            
            
            
        })
        
        ref.observe(.value, with: { (snapshot) in
            for child in snapshot.children
            {
                let dict = (child as! DataSnapshot).value as! NSDictionary
                if let orgName2 = dict["orgName"] as? String
                {
                    if orgName2 == self.orgNameText
                    {
                        self.organization = dict
                        self.orgName.text! = self.orgNameText
                        self.numReports.text! = "\(self.organization["numReports"] as! Int)"
                        self.numUsers.text! = "\((self.organization["usersInOrganization"] as! [String]).count)"
                        self.descriptionInfo.text = self.organization["description"] as! String
                        break
                    }
                }
            }
        })
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

        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Join", style: .plain, target: self, action: #selector(joinOrg))
        
    }
    
    @objc func joinOrg()
    {
        
        if !organizationArray.contains(orgName.text!)
        {
            let alertVC = UIAlertController(title: "Are you sure you want to join \(orgName.text!)?", message: nil, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                
                let ref2 = Database.database().reference(withPath: "users/\(self.defaults.value(forKey: "user")!)/organization")
                self.organizationArray.append(self.orgName.text!)
                ref2.setValue(self.organizationArray)
                
                var y = self.organization["usersInOrganization"] as! [String]
                y.append(Auth.auth().currentUser!.email!)
                
                let ref1 = Database.database().reference(withPath: "organizations/\(self.orgName.text!)/usersInOrganization")
                ref1.setValue(y)
                
            }))
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alertVC, animated: true, completion: nil)
        }
        else
        {
            let alertVC = UIAlertController(title: "You're already a part of this organization.", message: nil, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alertVC, animated: true, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count + 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0
        {
            return 30
        }
        else
        {
            return 85
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "asdfasdf")!
            return cell
        }
        if indexPath.row == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "asdf") as! OrganizationSingleReportCell
            cell.reportName.text! = "Collective Data"
            cell.date.text! = ""
            cell.addedBy.text! = ""
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "asdf") as! OrganizationSingleReportCell
        cell.reportName.text! = reports[indexPath.row-2]["name"] as! String
        cell.date.text! = reports[indexPath.row-2]["date"] as! String
        cell.addedBy.text! = reports[indexPath.row-2]["addedByUser"] as! String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1
        {
            first = true
            performSegue(withIdentifier: "showReportSeg", sender: nil)
        }
        else
        {
            first = false
            sendingDict = reports[indexPath.row-2]
            performSegue(withIdentifier: "showReportSeg", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReportSeg"
        {
            let dvc = segue.destination as! OrgDetailReportVC
            dvc.currentDic = sendingDict
            dvc.first = first
            dvc.organization = orgName.text!
        }
    }
    
    
    
    
}

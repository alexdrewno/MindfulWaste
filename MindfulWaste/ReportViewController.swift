import UIKit
import FirebaseDatabase
import FirebaseAuth
import FoldingCell


class ReportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    let categories = ["Fruits", "Vegetables", "Protein", "Dairy", "Grains", "Oils"]
    let colors = [UIColor.red, UIColor.green, UIColor.brown, UIColor.lightGray, UIColor.yellow, UIColor.orange]
    var amount = [0,0,0,0,0,0]
    let ref = FIRDatabase.database().reference(withPath: "reports")
    @IBOutlet var tableView: UITableView!
    let kCloseCellHeight: CGFloat = 179
    let kOpenCellHeight: CGFloat = 488
    
    override func viewDidLoad()
    {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    @IBAction func showHomeScreen(_ sender: Any)
    {
        sideMenuController?.performSegue(withIdentifier: "showCenterController1", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    
   
    @IBAction func saveAction(_ sender: Any)
    {
        if FIRAuth.auth()!.currentUser != nil
        {
            let alert = UIAlertController(title: "Save Report", message: "Name your report", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addTextField(configurationHandler: nil)
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_:UIAlertAction) in
                let report = Report(name:alert.textFields![0].text!,f: self.amount[0], v: self.amount[1], p: self.amount[2], d: self.amount[3], g: self.amount[4], o: self.amount[5],user: FIRAuth.auth()!.currentUser!.email!)
                if alert.textFields![0].hasText
                {
                    let groceryItemRef = self.ref.child(alert.textFields![0].text!.lowercased())
                    groceryItemRef.setValue(report.toAnyObject())
                }
                
                
            }))
            present(alert, animated: false, completion: nil)
        }
    }
}

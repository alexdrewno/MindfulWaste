import UIKit
import FirebaseDatabase
import FirebaseAuth
import FoldingCell

fileprivate struct C {
    struct CellHeight {
        static let close: CGFloat = 179
        static let open: CGFloat = 493
    }
}

class ReportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    let categories = ["Fruits", "Vegetables", "Protein", "Dairy", "Grains", "Oils"]
    let colors = [UIColor.red, UIColor.green, UIColor.brown, UIColor.lightGray, UIColor.yellow, UIColor.orange]
    var amount = [0,0,0,0,0,0]
    let ref = FIRDatabase.database().reference(withPath: "reports")
    @IBOutlet var tableView: UITableView!
    let kCloseCellHeight: CGFloat = 179
    let kOpenCellHeight: CGFloat = 493
    var cellHeights : [CGFloat] = []
    
    override func viewDidLoad()
    {
        tableView.delegate = self
        tableView.dataSource = self
        
        cellHeights = (0..<categories.count).map { _ in C.CellHeight.close }
    }
    
    
    @IBAction func showHomeScreen(_ sender: Any)
    {
        sideMenuController?.performSegue(withIdentifier: "showCenterController1", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        var duration = 0.0
        if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 1.1
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { _ in
            tableView.beginUpdates()
            tableView.endUpdates()
            }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if case let cell as FoldingCell = cell {
            if cellHeights[indexPath.row] == C.CellHeight.close {
                cell.selectedAnimation(false, animated: false, completion:nil)
            } else {
                cell.selectedAnimation(true, animated: false, completion: nil)
            }
        }
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

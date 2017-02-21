import UIKit
import FirebaseDatabase
import FirebaseAuth
import FoldingCell
import Charts

fileprivate struct C {
    struct CellHeight {
        static let close: CGFloat = 179
        static let open: CGFloat = 493
    }
}

class ReportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FoldingCellDelegate
{
    let categories = ["Fruits", "Vegetables", "Dry Goods", "Dairy", "Misc."]
    let colors = [UIColor.red, UIColor.green, UIColor.yellow, UIColor.lightGray, UIColor.orange]
    var amount : [CGFloat] = [0,0,0,0,0]
    var detailFruitAmount : [CGFloat] = [0,0,0,0]
    var detailVegetablesAmount : [CGFloat] = [0,0,0,0]
    var detailDryGoodsAmount : [CGFloat] = [0,0,0,0,0,0,0,0,0]
    var detailDairyAmount : [CGFloat] = [0,0,0,0,0,0]
    var detailMiscAmount : [CGFloat] = [0]
    let ref = FIRDatabase.database().reference(withPath: "reports")
    @IBOutlet var tableView: UITableView!
    let kCloseCellHeight: CGFloat = 179
    let kOpenCellHeight: CGFloat = 493
    var cellHeights : [CGFloat] = []
    var descriptions : [[String]] = []
    
    
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
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportCell", for: indexPath) as! ReportCell
        
        cell.foregroundView.backgroundColor = colors[indexPath.row]
        cell.leftView.backgroundColor = colors[indexPath.row].darker(by: 20.0)
        cell.amountLabel.backgroundColor = colors[indexPath.row].darker()
        cell.groupLabel.text = categories[indexPath.row]
        cell.amountLabel.text = "\(amount[indexPath.row]) lbs."
        cell.containerView.backgroundColor = colors[indexPath.row].lighter(by: 10.0)
        cell.innerContainer.backgroundColor = colors[indexPath.row].lighter(by: 45.0)
        cell.backViewColor = colors[indexPath.row].darker(by: 45.0)!
        cell.topView.backgroundColor = colors[indexPath.row].darker(by: 20.0)
        cell.categoryContainerLabel.text = categories[indexPath.row]
        cell.delegate = self
    
        return cell
    }
    
    func updateInfo(groupName: String, array: [CGFloat])
    {
        switch groupName{
        
        case "Fruits":
            detailFruitAmount = array
            print("fruit", detailFruitAmount)
            amount[0] = 0
            for num in detailFruitAmount
            {
                amount[0] += num
            }
        case "Vegetables":
            detailVegetablesAmount = array
            print("vegatables", detailVegetablesAmount)
            amount[1] = 0
            for num in detailVegetablesAmount
            {
                amount[1] += num
            }
        case "Dry Goods":
            detailDryGoodsAmount = array
            print("Dry Goods", detailDryGoodsAmount)
            amount[2] = 0
            for num in detailDryGoodsAmount
            {
                amount[2] += num
            }
        case "Dairy":
            detailDairyAmount = array
            print("Dairy", detailDairyAmount)
            amount[3] = 0
            for num in detailDairyAmount
            {
                amount[3] += num
            }
        case "Misc.":
            detailMiscAmount = array
            print("Misc.", detailMiscAmount)
            amount[4] = 0
            for num in detailMiscAmount
            {
                amount[4] += num
            }
        default:
            break
        
        }
    }
    
    func finishedEditing() {
        self.tableView.reloadData()
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath) as! ReportCell
        
        switch indexPath.row{
        case 0:
            cell.descriptions = ["Whole Fruit", "Packaged Fruit", "Fruit Juice", "Other Fruit"]
            cell.amountValues = detailFruitAmount
            cell.insideTableView.reloadData()
            cell.amountLabel.text = "\(amount[0]) lbs."
        case 1:
            cell.descriptions =  ["Vegetables", "Packaged Vegetables", "Vegetable Juice", "Other Vegetables"]
            cell.amountValues = detailVegetablesAmount
            cell.insideTableView.reloadData()
            cell.amountLabel.text = "\(amount[1]) lbs"
        case 2:
            cell.descriptions =  ["Misc. Bagged Snacks", "Fruit & Grain Bars", "Crackers", "Raisins", "Dry Cereal", "Granola", "Muffins", "Chips", "Other Dry Goods"]
            cell.amountValues = detailDryGoodsAmount
            cell.insideTableView.reloadData()
            cell.amountLabel.text = "\(amount[2]) lbs"
        case 3:
            cell.descriptions = ["Cheese", "Yogurt", "White Milk", "Chocolate Milk", "Strawberry Milk", "Other Dairy"]
            cell.amountValues = detailDairyAmount
            cell.insideTableView.reloadData()
            cell.amountLabel.text = "\(amount[3]) lbs"
        case 4:
            cell.descriptions = ["Items such as PB&J, etc."]
            cell.amountValues = detailMiscAmount
            cell.insideTableView.reloadData()
            cell.amountLabel.text = "\(amount[4]) lbs"
        default:
            break;
        }
        
        
        
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
     
        
        
        if case let cell as ReportCell = cell {
            cell.updateChartWithData()
            if cellHeights[indexPath.row] == C.CellHeight.close {
                cell.selectedAnimation(false, animated: false, completion:nil)
            } else {
                cell.selectedAnimation(true, animated: false, completion: nil)
            }
        }
    }

    @IBAction func saveReport(_ sender: AnyObject) {
        
        if FIRAuth.auth()!.currentUser != nil
        {
            let alert = UIAlertController(title: "Save Report", message: "Name your report", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addTextField(configurationHandler: nil)
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_:UIAlertAction) in
                let report = Report(name: alert.textFields![0].text!, amount: self.amount, f: self.detailFruitAmount, v: self.detailVegetablesAmount, dg: self.detailDryGoodsAmount, d: self.detailDairyAmount, m: self.detailMiscAmount, user: FIRAuth.auth()!.currentUser!.email!)
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

extension UIColor {
    
    func lighter(by percentage:CGFloat=30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    func darker(by percentage:CGFloat=30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    func adjust(by percentage:CGFloat=30.0) -> UIColor? {
        var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat=0;
        if(self.getRed(&r, green: &g, blue: &b, alpha: &a)){
            return UIColor(red: min(r + percentage/100, 1.0),
                           green: min(g + percentage/100, 1.0),
                           blue: min(b + percentage/100, 1.0),
                           alpha: a)
        }else{
            return nil
        }
    }
}

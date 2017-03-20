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
    
    @IBAction func showLiveFeed(_ sender: AnyObject) {
        sideMenuController?.performSegue(withIdentifier: "showLiveFeed", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportCell", for: indexPath) as! ReportCell
        
        print("UPDATING")
        
        cell.foregroundView.backgroundColor = colors[indexPath.row]
        cell.leftView.backgroundColor = colors[indexPath.row].darker(by: 20.0)
        cell.amountLabel.backgroundColor = colors[indexPath.row].darker()
        cell.groupLabel.text = categories[indexPath.row]
        cell.amountLabel.text = "\(amount[indexPath.row]) lbs."
        cell.amount = amount[indexPath.row]
        
        cell.containerView.backgroundColor = colors[indexPath.row].lighter(by: 10.0)
        cell.innerContainer.backgroundColor = colors[indexPath.row].lighter(by: 45.0)
        cell.progressCircle.set(colors: colors[indexPath.row], UIColor.white)
        cell.backViewColor = colors[indexPath.row].darker(by: 45.0)!
        cell.topView.backgroundColor = colors[indexPath.row].darker(by: 20.0)
        cell.categoryContainerLabel.text = categories[indexPath.row]

        cell.delegate = self
        
        switch indexPath.row{
        case 0:
            cell.descriptions = ["Whole Fruit", "Packaged Fruit", "Fruit Juice", "Other Fruit"]
        case 1:
            cell.descriptions = ["Vegetables", "Packaged Vegetables", "Vegetable Juice", "Other Vegetables"]
        case 2:
            cell.descriptions = ["Misc. Bagged Snacks", "Fruit & Grain Bars", "Crackers", "Raisins", "Dry Cereal", "Granola", "Muffins", "Chips", "Other Dry Goods"]
        case 3:
            cell.descriptions = ["Cheese", "Yogurt", "White Milk", "Chocolate Milk", "Strawberry Milk", "Other Dairy"]
        case 4:
            cell.descriptions = ["Items such as PB&J, etc."]
        default:
            break;
        }
    
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
            cell.updateCircularProgress()
            cell.progressCircle.angle = Double(amount[0]/100.0 * 360.0)
            print("fruit", cell.progressCircle.angle)
            
        case 1:
            cell.descriptions =  ["Vegetables", "Packaged Vegetables", "Vegetable Juice", "Other Vegetables"]
            cell.amountValues = detailVegetablesAmount
            cell.insideTableView.reloadData()
            cell.amountLabel.text = "\(amount[1]) lbs"
            cell.updateCircularProgress()
            cell.progressCircle.angle = Double(amount[1]/100.0 * 360.0)
             print("v", cell.progressCircle.angle)
        case 2:
            cell.descriptions =  ["Misc. Bagged Snacks", "Fruit & Grain Bars", "Crackers", "Raisins", "Dry Cereal", "Granola", "Muffins", "Chips", "Other Dry Goods"]
            cell.amountValues = detailDryGoodsAmount
            cell.insideTableView.reloadData()
            cell.amountLabel.text = "\(amount[2]) lbs"
            cell.updateCircularProgress()
            cell.progressCircle.angle = Double(amount[2]/100.0 * 360.0)
             print("dg", cell.progressCircle.angle)
        case 3:
            cell.descriptions = ["Cheese", "Yogurt", "White Milk", "Chocolate Milk", "Strawberry Milk", "Other Dairy"]
            cell.amountValues = detailDairyAmount
            cell.insideTableView.reloadData()
            cell.amountLabel.text = "\(amount[3]) lbs"
            cell.updateCircularProgress()
            cell.progressCircle.angle = Double(amount[3]/100.0 * 360.0)
             print("d", cell.progressCircle.angle)
        case 4:
            cell.descriptions = ["Items such as PB&J, etc."]
            cell.amountValues = detailMiscAmount
            cell.insideTableView.reloadData()
            cell.amountLabel.text = "\(amount[4]) lbs"
            cell.updateCircularProgress()
            cell.progressCircle.angle = Double(amount[4]/100.0 * 360.0)
             print("m", cell.progressCircle.angle)
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
        
        UIView.animate(withDuration: duration, delay: 0.01, options: .curveEaseOut, animations: { _ in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion:  { (bool) in
            
        })
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
     
        
        
        if case let cell as ReportCell = cell {
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
                   // self.sideMenuController?.performSegue(withIdentifier: "showInfographic", sender: nil)
                }
                else
                {
                    let alert2 = UIAlertController(title: "Error", message: "Please type in a unique report name.", preferredStyle: .alert)
                    alert2.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                        self.present(alert,animated: false)
                    }))
                }
                
                
            }))
            present(alert, animated: false, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInfographic"
        {
//            print("called")
//            let dvc = segue.destination as! ReportInfographic
//            dvc.amountArray = amount as! [CGFloat]
//            var highest: CGFloat = 0
//            var total : CGFloat = 0
//            var indexOfHighest : Int = 0
//            for i in 0...amount.count
//            {
//                if amount[i] > highest
//                {
//                    highest = amount[i]
//                }
//                
//                total += amount[i]
//                
//            }
//            
//            dvc.totalAmountLabel.text = "\(total)"
//            dvc.mostAmountLabel.text = "\(highest)"
//            dvc.mostAmountCategoryLabel.text = "\(categories[indexOfHighest])"
//            
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

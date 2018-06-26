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
    var number : [CGFloat] = [0,0,0,0,0]
    var detailFruitAmount : [CGFloat] = [0,0,0,0]
    var detailVegetablesAmount : [CGFloat] = [0,0,0,0]
    var detailDryGoodsAmount : [CGFloat] = [0,0,0,0,0,0,0,0,0]
    var detailDairyAmount : [CGFloat] = [0,0,0,0,0,0]
    var detailMiscAmount : [CGFloat] = [0]
    var detailFruitNumber : [CGFloat] = [0,0,0,0]
    var detailVegetablesNumber : [CGFloat] = [0,0,0,0]
    var detailDryGoodsNumber : [CGFloat] = [0,0,0,0,0,0,0,0,0]
    var detailDairyNumber : [CGFloat] = [0,0,0,0,0,0]
    var detailMiscNumber : [CGFloat] = [0]
    let ref = Database.database().reference(withPath: "reports")
    @IBOutlet var tableView: UITableView!
    let kCloseCellHeight: CGFloat = 179
    let kOpenCellHeight: CGFloat = 493
    var cellHeights : [CGFloat] = []
    var descriptions : [[String]] = []
    let defaults = UserDefaults()
    var organizationArray = [String]()

    
    
    override func viewDidLoad()
    {
        tableView.delegate = self
        tableView.dataSource = self
        
        cellHeights = (0..<categories.count).map { _ in C.CellHeight.close }
        
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
        cell.backViewColor = colors[indexPath.row].darker(by: 45.0)!
        cell.topView.backgroundColor = colors[indexPath.row].darker(by: 20.0)
        cell.categoryContainerLabel.text = categories[indexPath.row]

        cell.delegate = self
        
        switch indexPath.row{
        case 0:
            cell.descriptions = ["Whole Fruit", "Packaged Fruit", "Fruit Juice", "Other Fruit"]
            cell.cellCategories.text! = "Whole Fruit, Packaged Fruit, Fruit Juice, Other Fruit"
        case 1:
            cell.descriptions = ["Vegetables", "Packaged Vegetables", "Vegetable Juice", "Other Vegetables"]
            cell.cellCategories.text! = "Vegetables, Packaged Vegetables, Vegetable Juice, Other Vegetables"
        case 2:
            cell.descriptions = ["Misc. Bagged Snacks", "Fruit & Grain Bars", "Crackers", "Raisins", "Dry Cereal", "Granola", "Muffins", "Chips", "Other Dry Goods"]
            cell.cellCategories.text! = "Misc. Bagged Snacks, Fruit and Grain Bars, Crackers, Raisins, Dry Cereal, Granola, Muffins, Chips, Other Dry Goods"
        case 3:
            cell.descriptions = ["Cheese", "Yogurt", "White Milk", "Chocolate Milk", "Strawberry Milk", "Other Dairy"]
            cell.cellCategories.text! = "Cheese, Yogurt, White Milk, Chocolate Milk, Strawberry Milk, Other Dairy"
        case 4:
            cell.descriptions = ["Items such as PB&J, etc."]
            cell.cellCategories.text! = "Items such as PB&J, etc."
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
    
    func updateNumber(groupName: String, array : [CGFloat])
    {
        switch groupName{
            
        case "Fruits":
            detailFruitNumber = array
            print("fruit", detailFruitNumber)
            number[0] = 0
            for num in detailFruitNumber
            {
                number[0] += num
            }
        case "Vegetables":
            detailVegetablesNumber = array
            print("vegatables", detailVegetablesNumber)
            number[1] = 0
            for num in detailVegetablesNumber
            {
                number[1] += num
            }
        case "Dry Goods":
            detailDryGoodsNumber = array
            print("Dry Goods", detailDryGoodsNumber)
            number[2] = 0
            for num in detailDryGoodsNumber
            {
                number[2] += num
            }
        case "Dairy":
            detailDairyNumber = array
            print("Dairy", detailDairyNumber)
            number[3] = 0
            for num in detailDairyNumber
            {
                number[3] += num
            }
        case "Misc.":
            detailMiscNumber = array
            print("Misc.", detailMiscNumber)
            number[4] = 0
            for num in detailMiscNumber
            {
                number[4] += num
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
            cell.numberValues = detailFruitNumber
            cell.insideTableView.reloadData()
            cell.amountLabel.text = "\(amount[0]) lbs."
            
        case 1:
            cell.descriptions =  ["Vegetables", "Packaged Vegetables", "Vegetable Juice", "Other Vegetables"]
            cell.amountValues = detailVegetablesAmount
            cell.numberValues = detailVegetablesNumber
            cell.insideTableView.reloadData()
            cell.amountLabel.text = "\(amount[1]) lbs"
        case 2:
            cell.descriptions =  ["Misc. Bagged Snacks", "Fruit & Grain Bars", "Crackers", "Raisins", "Dry Cereal", "Granola", "Muffins", "Chips", "Other Dry Goods"]
            cell.amountValues = detailDryGoodsAmount
            cell.numberValues = detailDryGoodsNumber
            cell.insideTableView.reloadData()
            cell.amountLabel.text = "\(amount[2]) lbs"
        case 3:
            cell.descriptions = ["Cheese", "Yogurt", "White Milk", "Chocolate Milk", "Strawberry Milk", "Other Dairy"]
            cell.amountValues = detailDairyAmount
            cell.amountValues = detailDairyNumber
            cell.insideTableView.reloadData()
            cell.amountLabel.text = "\(amount[3]) lbs"
        case 4:
            cell.descriptions = ["Items such as PB&J, etc."]
            cell.amountValues = detailMiscAmount
            cell.amountValues = detailMiscNumber
            cell.insideTableView.reloadData()
            cell.amountLabel.text = "\(amount[4]) lbs"
        default:
            break;
        }
        
        
        
        var duration = 0.0
        if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 1.1
        }
        
        UIView.animate(withDuration: duration, delay: 0.01, options: .curveEaseOut, animations: { 
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion:  { (bool) in
            
        })
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
     
        
        
        if case let cell as ReportCell = cell {
            if cellHeights[indexPath.row] == C.CellHeight.close {
                cell.unfold(false, animated: false, completion:nil)
            } else {
                cell.unfold(true, animated: false, completion: nil)
            }
        }
    }

    @IBAction func saveReport(_ sender: AnyObject) {
        
        if Auth.auth().currentUser != nil
        {
            let alert = UIAlertController(title: "Save Report", message: "Name your report", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addTextField(configurationHandler: nil)
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_:UIAlertAction) in
                
                
                let alert2 = UIAlertController(title: "Under which organization?", message: nil, preferredStyle: .actionSheet)
            
                for name in self.organizationArray
                {
                    alert2.addAction(UIAlertAction(title: name, style: .default, handler: { (action) in
                        
                        var alert3 = UIAlertController()
                        if action.title! != ""
                        {
                            alert3 = UIAlertController(title: "Under '\(action.title!)?'", message: nil, preferredStyle: .alert)
                        }
                        else
                        {
                            alert3 = UIAlertController(title: "Not under an organization?", message: nil, preferredStyle: .alert)
                        }
                        alert3.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action2) in
                            
                            let report = Report(name: alert.textFields![0].text!, amount: self.amount, number: self.number, f: self.detailFruitAmount, v: self.detailVegetablesAmount, dg: self.detailDryGoodsAmount, d: self.detailDairyAmount, m: self.detailMiscAmount, fn: self.detailFruitNumber, vn: self.detailVegetablesNumber, dgn: self.detailDryGoodsNumber, dn: self.detailDairyNumber, mn: self.detailMiscNumber, user: Auth.auth().currentUser!.email!, org: action.title!)
                            if alert.textFields![0].hasText
                            {
                                let groceryItemRef = self.ref.child(alert.textFields![0].text!.lowercased())
                                groceryItemRef.setValue(report.toAnyObject())
                                self.defaults.set(report.toAnyObject() as! NSDictionary, forKey: "mostRecentReportName")
                                self.sideMenuController?.performSegue(withIdentifier: "showInfographic", sender: nil)
                                let ref1 = Database.database().reference()
                                
                                ref1.child("organizations").observeSingleEvent(of: .value, with: { (snapshot) in
                                    
                                    let dict = snapshot.value as! NSDictionary
                                    if action.title! != ""
                                    {
                                        let newVal = (dict[action.title!] as! NSDictionary)["numReports"] as! Int
                                        ref1.child("organizations/\(action.title!)/numReports").setValue(newVal + 1)
                                    }
                                    
                                })
                            }
                            else
                            {
                                let alert2 = UIAlertController(title: "Error", message: "Please type in a unique report name.", preferredStyle: .alert)
                                alert2.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                                    self.present(alert,animated: false)
                                }))
                            }
                            
                            
                        }))
                        alert3.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                            self.present(alert2, animated: true, completion: nil)
                        }))
                        
                        self.present(alert3, animated: true, completion: nil)
                    }))
                }
                alert2.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                self.present(alert2, animated: true, completion: nil)
                
                
                
                
                
                
                
                
            }))
            present(alert, animated: false, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print(segue.identifier)
        if segue.identifier == "showInfographic"
        {
            let dvc = segue.destination as! ReportInfographic
            dvc.amountArray = amount
            var highest: CGFloat = 0
            var total : CGFloat = 0
            var indexOfHighest : Int = 0
            for i in 0...amount.count
            {
                if amount[i] > highest
                {
                    highest = amount[i]
                }
                
                total += amount[i]
                
            }
            
            dvc.totalAmountLabel.text = "\(total)"
            dvc.mostAmountLabel.text = "\(highest)"
            dvc.mostAmountCategoryLabel.text = "\(categories[indexOfHighest])"
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

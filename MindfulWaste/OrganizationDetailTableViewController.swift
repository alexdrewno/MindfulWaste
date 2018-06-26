import UIKit
import expanding_collection
import FirebaseDatabase
import FirebaseAuth

class OrganizationDetailTableViewController : ExpandingTableViewController
{
    let colors = [UIColor.white,UIColor.red, UIColor.green, UIColor.yellow, UIColor.lightGray, UIColor.orange]
    let defaults = UserDefaults()
    var currentDic : NSDictionary!
    var selfReports = [NSDictionary]()
    var totalReports: [[CGFloat]] = Array(repeating: Array(repeating: 0, count: 5), count: 5)
    var bool2 = false
    
    
    override func viewDidLoad()
    {
        navigationItem.hidesBackButton = true
        if let bool = defaults.value(forKey: "firstCell")
        {
            bool2 = bool as! Bool
            if !(bool as! (Bool))
            {
                currentDic = defaults.value(forKey: "pressedReport") as! NSDictionary
            }
            else
            {
                let ref = Database.database().reference(withPath: "reports")
                ref.observeSingleEvent(of: .value, with: { (snapshot) in
                    for child in snapshot.children
                    {
                        let dict = (child as! DataSnapshot).value as! NSDictionary
                        
                        if dict["addedByUser"] as! String == Auth.auth().currentUser?.email!
                        {
                            self.selfReports.append(dict)
                            
                        }
                        
                        
                        
                    }
                    
                    
                    
                    var totalFruit: CGFloat = 0
                    var totalMisc: CGFloat = 0.0
                    var totalDairy: CGFloat = 0.0
                    var totalDryGoods: CGFloat = 0.0
                    var totalVegetable: CGFloat = 0.0
                    var totalFruitNumber: CGFloat = 0
                    var totalMiscNumber: CGFloat = 0.0
                    var totalDairyNumber: CGFloat = 0.0
                    var totalDryGoodsNumber: CGFloat = 0.0
                    var totalVegetableNumber: CGFloat = 0.0

                    for item in self.selfReports
                    {
                        totalFruit += (item["fruitInformation"] as! NSDictionary)["fruitAmount"] as! CGFloat
                        totalMisc += (item["miscInformation"] as! NSDictionary)["miscAmount"] as! CGFloat
                        totalDairy += (item["dairyInformation"] as! NSDictionary)["dairyAmount"] as! CGFloat
                        totalDryGoods += (item["dryGoodsInformation"] as! NSDictionary)["dryGoodsAmount"] as! CGFloat
                        totalVegetable += (item["vegetableInformation"] as! NSDictionary)["vegetableAmount"] as! CGFloat
                        totalFruitNumber += (item["fruitInformation"] as! NSDictionary)["fruitNumber"] as! CGFloat
                        totalMiscNumber += (item["miscInformation"] as! NSDictionary)["miscNumber"] as! CGFloat
                        totalDairyNumber += (item["dairyInformation"] as! NSDictionary)["dairyNumber"] as! CGFloat
                        totalDryGoodsNumber += (item["dryGoodsInformation"] as! NSDictionary)["dryGoodsNumber"] as! CGFloat
                        totalVegetableNumber += (item["vegetableInformation"] as! NSDictionary)["vegetableNumber"] as! CGFloat
                    }
                    
                    self.totalReports[0][0] = totalFruit
                    self.totalReports[0][1] = totalFruitNumber
                    self.totalReports[1][0] = totalVegetable
                    self.totalReports[1][1] = totalVegetableNumber
                    self.totalReports[2][0] = totalDryGoods
                    self.totalReports[2][1] = totalDryGoodsNumber
                    self.totalReports[3][0] = totalDairy
                    self.totalReports[3][1] = totalDairyNumber
                    self.totalReports[4][0] = totalMisc
                    self.totalReports[4][1] = totalMiscNumber
                    
                    
                    
                    

                    
                    
                    self.tableView.reloadData()
                })
            }
        }
        
    }

    
    @IBAction func removeCurrentVC(_ sender: Any) {
        self.popTransitionAnimation()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailedReportCell2") as! DetailedReportCell
        cell.cellView.backgroundColor = colors[indexPath.row]
        
        if bool2 && selfReports.count != 0
        {
            switch indexPath.row
            {
            case 1:
                cell.details!.text! = "Fruit"
                cell.amount!.text! = "\(totalReports[0][0])"
                cell.number!.text! = "\(totalReports[0][1])"
            case 2:
                cell.details!.text! = "Vegetables"
                cell.amount!.text! = "\(totalReports[1][0])"
                cell.number!.text! = "\(totalReports[1][1])"
            case 3:
                cell.details!.text! = "Dry Goods"
                cell.amount!.text! = "\(totalReports[2][0])"
                cell.number!.text! = "\(totalReports[2][1])"
            case 4:
                cell.details!.text! = "Dairy"
                cell.amount!.text! = "\(totalReports[3][0])"
                cell.number!.text! = "\(totalReports[3][1])"
            case 5:
                cell.details!.text! = "Misc."
                cell.amount!.text! = "\(totalReports[4][0])"
                cell.number!.text! = "\(totalReports[4][1])"
            default:
                break
            }
        }
        else if !bool2
        {
            switch indexPath.row
            {
            case 1:
                cell.details!.text! = "Fruit"
                cell.amount!.text! = "\((currentDic["fruitInformation"] as! NSDictionary)["fruitAmount"] as! CGFloat)"
                cell.number!.text! = "\((currentDic["fruitInformation"] as! NSDictionary)["fruitNumber"] as! CGFloat)"
            case 2:
                cell.details!.text! = "Vegetables"
                cell.amount!.text! = "\((currentDic["vegetableInformation"] as! NSDictionary)["vegetableAmount"] as! CGFloat)"
                cell.number!.text! = "\((currentDic["vegetableInformation"] as! NSDictionary)["vegetableNumber"] as! CGFloat)"
            case 3:
                cell.details!.text! = "Dry Goods"
                cell.amount!.text! = "\((currentDic["dryGoodsInformation"] as! NSDictionary)["dryGoodsAmount"] as! CGFloat)"
                cell.number!.text! = "\((currentDic["dryGoodsInformation"] as! NSDictionary)["dryGoodsNumber"] as! CGFloat)"
            case 4:
                cell.details!.text! = "Dairy"
                cell.amount!.text! = "\((currentDic["dairyInformation"] as! NSDictionary)["dairyAmount"] as! CGFloat)"
                cell.number!.text! = "\((currentDic["dairyInformation"] as! NSDictionary)["dairyNumber"] as! CGFloat)"
            case 5:
                cell.details!.text! = "Misc."
                cell.amount!.text! = "\((currentDic["miscInformation"] as! NSDictionary)["miscAmount"] as! CGFloat)"
                cell.number!.text! = "\((currentDic["miscInformation"] as! NSDictionary)["miscNumber"] as! CGFloat)"
            default:
                break
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
}

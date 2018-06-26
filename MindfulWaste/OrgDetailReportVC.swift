import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class OrgDetailReportVC: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var reportName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var addedBy: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var currentDic : NSDictionary!
    let colors = [UIColor.white, UIColor.red, UIColor.green, UIColor.yellow, UIColor.lightGray, UIColor.orange]
    var first = false
    var selfReports = [NSDictionary]()
    var totalReports: [[CGFloat]] = Array(repeating: Array(repeating: 0, count: 5), count: 5)
    var organization = ""


    
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        if !first        {
            reportName.text! = currentDic["name"] as! String
            date.text! = currentDic["date"] as! String
            addedBy.text! = currentDic["addedByUser"] as! String
        }
        if first
        {
            reportName.text! = "Collective Data"
            date.text! = ""
            addedBy.text! = ""
            first = true
            let ref = Database.database().reference(withPath: "reports")
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                for child in snapshot.children
                {
                    let dict = (child as! DataSnapshot).value as! NSDictionary
                    
                    if dict["organization"] as! String == self.organization
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailedReportCell2") as! DetailedReportCell
        cell.cellView.backgroundColor = colors[indexPath.row]
        if first
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailedReportCell2") as! DetailedReportCell
            cell.cellView.backgroundColor = colors[indexPath.row]
            
            
            
            
            switch indexPath.row
            {
            case 0:
                cell.details!.text! = "Description"
                cell.amount!.text! = "Weight"
                cell.number!.text! = "Number"
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
            return cell

        }
        
        switch indexPath.row
        {
        case 0:
            cell.details!.text! = "Description"
            cell.amount!.text! = "Weight"
            cell.number!.text! = "Number"
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
        return cell

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
}

import UIKit
import expanding_collection

class OrganizationDetailTableViewController : ExpandingTableViewController
{
    let colors = [UIColor.white,UIColor.red, UIColor.green, UIColor.yellow, UIColor.lightGray, UIColor.orange]
    let defaults = UserDefaults()
    var currentDic : NSDictionary!
    
    
    override func viewDidLoad()
    {
        navigationItem.hidesBackButton = true
        currentDic = defaults.value(forKey: "pressedReport") as! NSDictionary
    }

    
    @IBAction func removeCurrentVC(_ sender: Any) {
        self.popTransitionAnimation()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailedReportCell2") as! DetailedReportCell
        cell.cellView.backgroundColor = colors[indexPath.row]
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
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
}

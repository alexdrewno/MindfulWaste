import UIKit
import Firebase

class LiveFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet var tableView: UITableView!
    var data : NSMutableDictionary = [:]
    
    
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        let ref = FIRDatabase.database().reference(withPath: "reports")
        ref.observe(.value, with: { snapshot in
            
            self.data = [:]
            for child in snapshot.children
            {
                
                let dict = (child as! FIRDataSnapshot).value as! NSDictionary
                print(dict, dict["name"])
                self.data.setObject(dict, forKey: dict["name"] as! String as NSCopying)
            }
            
            self.tableView.reloadData()
        })
        
        
        
    }
    
    @IBAction func showHomeScreen(_ sender: AnyObject) {
        
        sideMenuController?.performSegue(withIdentifier: "showCenterController1", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as! FeedTableViewCell
        cell.selectionStyle = .none
        var total = (((data[data.allKeys[indexPath.row]] as! NSDictionary)["miscInformation"] as! NSDictionary)["miscAmount"] as! CGFloat) + (((data[data.allKeys[indexPath.row]] as! NSDictionary)["dairyInformation"] as! NSDictionary)["dairyAmount"] as! CGFloat) + (((data[data.allKeys[indexPath.row]] as! NSDictionary)["dryGoodsInformation"] as! NSDictionary)["dryGoodsAmount"] as! CGFloat) + (((data[data.allKeys[indexPath.row]] as! NSDictionary)["vegetableInformation"] as! NSDictionary)["vegetableAmount"] as! CGFloat) + (((data[data.allKeys[indexPath.row]] as! NSDictionary)["fruitInformation"] as! NSDictionary)["fruitAmount"] as! CGFloat)
        cell.amounts[0].text! = "\(((data[data.allKeys[indexPath.row]] as! NSDictionary)["fruitInformation"] as! NSDictionary)["fruitAmount"] as! CGFloat) lbs."
        cell.amounts[1].text! = "\(((data[data.allKeys[indexPath.row]] as! NSDictionary)["vegetableInformation"] as! NSDictionary)["vegetableAmount"] as! CGFloat) lbs."
        cell.amounts[2].text! = "\(((data[data.allKeys[indexPath.row]] as! NSDictionary)["dryGoodsInformation"] as! NSDictionary)["dryGoodsAmount"] as! CGFloat) lbs."
        cell.amounts[3].text! = "\(((data[data.allKeys[indexPath.row]] as! NSDictionary)["dairyInformation"] as! NSDictionary)["dairyAmount"] as! CGFloat) lbs."
        cell.amounts[4].text! = "\(((data[data.allKeys[indexPath.row]] as! NSDictionary)["miscInformation"] as! NSDictionary)["miscAmount"] as! CGFloat) lbs."
        cell.reportNameLabel.text! = data.allKeys[indexPath.row] as! String
        cell.totalAmount.text = "\(total) lbs."
        cell.email.text! = (data[data.allKeys[indexPath.row]] as! NSDictionary)["addedByUser"] as! String
        return cell
    }
    
    
    
}

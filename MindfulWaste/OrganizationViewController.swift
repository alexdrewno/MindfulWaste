import UIKit
import expanding_collection
import SideMenuController
import FirebaseDatabase
import FirebaseAuth

class OrganizationViewController : ExpandingViewController
{
    var items = ["banana", "banana2", "banana3"]
    fileprivate var cellsIsOpen = [Bool]()
    var selfReports = [NSDictionary]()
    var defaults = UserDefaults()
    
    override func viewDidLoad() {
        itemSize = CGSize(width: 214, height: 264)
        super.viewDidLoad()
        
        // register cell
        let nib = UINib(nibName: "OrganizationReportCell", bundle: nil)
        collectionView!.register(nib, forCellWithReuseIdentifier: "expandingCell")
        fillCellIsOpenArray()
        addGestureToView(self.view)
        
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
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
        
            self.collectionView?.reloadData()
        })
       
        
    
    }
    
    fileprivate func fillCellIsOpenArray() {
        for _ in items {
            cellsIsOpen.append(false)
        }
        cellsIsOpen.append(false)
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selfReports.count + 1
    }
    
     override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ("expandingCell"), for: indexPath as IndexPath) as! OrganizationReportCell
        
        if selfReports.count != 0
        {
            if indexPath.row == 0
            {
                var totalFruit: CGFloat = 0.0
                var totalMisc: CGFloat = 0.0
                var totalDairy: CGFloat = 0.0
                var totalDryGoods: CGFloat = 0.0
                var totalVegetable: CGFloat = 0.0
                var total: CGFloat = 0.0
                for item in selfReports
                {
                    totalFruit += (item["fruitInformation"] as! NSDictionary)["fruitAmount"] as! CGFloat
                    totalMisc += (item["miscInformation"] as! NSDictionary)["miscAmount"] as! CGFloat
                    totalDairy += (item["dairyInformation"] as! NSDictionary)["dairyAmount"] as! CGFloat
                    totalDryGoods += (item["dryGoodsInformation"] as! NSDictionary)["dryGoodsAmount"] as! CGFloat
                    totalVegetable += (item["vegetableInformation"] as! NSDictionary)["vegetableAmount"] as! CGFloat
                }
                
                total = totalVegetable + totalDryGoods + totalDairy + totalMisc + totalFruit
                
                cell.personNameLabel.text! = selfReports[0]["addedByUser"] as! String
                cell.totalAmountLabel.text! = "\(total)"
                cell.dateLabel.text! = selfReports[0]["date"] as! String
                cell.reportNameLabel.text! = "Collective Data"
            }
            else
            {
                
                let fruitAmount = (selfReports[indexPath.row-1]["fruitInformation"] as! NSDictionary)["fruitAmount"] as! CGFloat
                let miscAmount = (selfReports[indexPath.row-1]["miscInformation"] as! NSDictionary)["miscAmount"] as! CGFloat
                let dairyAmount = (selfReports[indexPath.row-1]["dairyInformation"] as! NSDictionary)["dairyAmount"] as! CGFloat
                let dryGoodsAmount = (selfReports[indexPath.row-1]["dryGoodsInformation"] as! NSDictionary)["dryGoodsAmount"] as! CGFloat
                let vegetableAmount = (selfReports[indexPath.row-1]["vegetableInformation"] as! NSDictionary)["vegetableAmount"] as! CGFloat
                var total = fruitAmount + miscAmount + dairyAmount + dryGoodsAmount + vegetableAmount
                cell.personNameLabel.text! = selfReports[indexPath.row-1]["addedByUser"] as! String
                cell.totalAmountLabel.text! = "\(total)"
                cell.dateLabel.text! = selfReports[indexPath.row-1]["date"] as! String
                cell.reportNameLabel.text! = selfReports[indexPath.row-1]["name"] as! String
                
                if selfReports[indexPath.row-1]["organization"] as! String != ""
                {
                    cell.organizationNameLabel.text! = selfReports[indexPath.row-1]["organization"] as! String
                }
                else
                {
                    cell.organizationNameLabel.text! = "No Organization"
                }
            }
        }

        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell =
            (collectionView.cellForItem(at: indexPath as IndexPath) as! OrganizationReportCell)
        
        print("selected")
           //defaults.set(selfReports[indexPath.row-1], forKey: "pressedReport")
        
        if cell.isOpened == false
        {
            cell.cellIsOpen(!cell.isOpened)
            cellsIsOpen[indexPath.row] = true
            
        }
        else
        {  print("push")
            
            pushToViewController(getViewController())
          
        }
        
        print("called")
    }
    
    fileprivate func getViewController() -> ExpandingTableViewController {
        let indexPath = IndexPath(row: currentIndex, section: 0)
        if indexPath.row == 0
        {
            defaults.set(true, forKey: "firstCell")
        }
        else
        {
            defaults.set(false, forKey: "firstCell")
            defaults.set(selfReports[indexPath.row-1], forKey: "pressedReport")
        }
        let storyboard = self.storyboard!
        let toViewController: OrganizationDetailTableViewController = storyboard.instantiateViewController(withIdentifier: "organizationTableView") as! OrganizationDetailTableViewController
        return toViewController
    }
    
    @IBAction func swipeGesture(_ sender: Any) {
        print("SWIPED")
        let indexPath = IndexPath(row: currentIndex, section: 0)
        if indexPath.row == 0
        {
            defaults.set(true, forKey: "firstCell")
        }
        else
        {
            defaults.set(false, forKey: "firstCell")
            defaults.set(selfReports[indexPath.row-1], forKey: "pressedReport")
        }
        guard let cell  = collectionView?.cellForItem(at: indexPath) as? OrganizationReportCell else { return }
        // double swipe Up transition
        if cell.isOpened == true && (sender as AnyObject).direction == .up {
            pushToViewController(getViewController())
        }
        
        if cell.isOpened == true && (sender as! AnyObject).direction == .up {
            pushToViewController(getViewController())
            
        }
        else if cell.isOpened == true && (sender as! AnyObject).direction == .down
        {
            cell.cellIsOpen(false)
        }
        
        let open = (sender as AnyObject).direction == .up ? true : false
        cell.cellIsOpen(open)
        cellsIsOpen[(indexPath as NSIndexPath).row] = cell.isOpened

        
    }
    
    @IBAction func showFeed(_ sender: Any) {
        sideMenuController?.performSegue(withIdentifier: "showLiveFeed", sender: self)
        print("showcenter")
    }
    
    @IBAction func showHome(_ sender: Any) {
        sideMenuController?.performSegue(withIdentifier: "showCenterController1", sender: nil)
    }
    

}

internal func Init<Type>(_ value : Type, block: (_ object: Type) -> Void) -> Type
{
    block(value)
    return value
}

extension OrganizationViewController {
    
    fileprivate func addGestureToView(_ toView: UIView) {
        let gesutereUp = Init(UISwipeGestureRecognizer(target: self, action: #selector(OrganizationViewController.swipeHandler(_:)))) {
            $0.direction = .up
        }
        
        let gesutereDown = Init(UISwipeGestureRecognizer(target: self, action: #selector(OrganizationViewController.swipeHandler(_:)))) {
            $0.direction = .down
        }
        toView.addGestureRecognizer(gesutereUp)
        toView.addGestureRecognizer(gesutereDown)
    }
    
    @objc func swipeHandler(_ sender: UISwipeGestureRecognizer) {
        let indexPath = IndexPath(row: currentIndex, section: 0)
        guard let cell  = collectionView?.cellForItem(at: indexPath) as? OrganizationReportCell else { return }
        // double swipe Up transition
        if cell.isOpened == true && sender.direction == .up {
            pushToViewController(getViewController())
        }
        
        let open = sender.direction == .up ? true : false
        cell.cellIsOpen(open)
        cellsIsOpen[(indexPath as NSIndexPath).row] = cell.isOpened
    }
}



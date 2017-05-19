import UIKit
import expanding_collection
import SideMenuController

class OrganizationViewController : ExpandingViewController
{
    var items = ["banana", "banana2", "banana3"]
    fileprivate var cellsIsOpen = [Bool]()
    override func viewDidLoad() {
        itemSize = CGSize(width: 214, height: 264)
        super.viewDidLoad()
        
        // register cell
        let nib = UINib(nibName: "OrganizationReportCell", bundle: nil)
        collectionView!.register(nib, forCellWithReuseIdentifier: "expandingCell")
        fillCellIsOpenArray()
        addGestureToView(self.view)
    }
    
    fileprivate func fillCellIsOpenArray() {
        for _ in items {
            cellsIsOpen.append(false)
        }
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
     override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ("expandingCell"), for: indexPath as IndexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell =
            (collectionView.cellForItem(at: indexPath as IndexPath) as! OrganizationReportCell)
        
        if cell.isOpened == false
        {
            cell.cellIsOpen(!cell.isOpened)
            cellsIsOpen[indexPath.row] = true
            
        }
        else
        {
            pushToViewController(getViewController())
            print("push")
        }
        
        print("called")
    }
    
    fileprivate func getViewController() -> ExpandingTableViewController {
        let storyboard = self.storyboard!
        let toViewController: OrganizationDetailTableViewController = storyboard.instantiateViewController(withIdentifier: "organizationTableView") as! OrganizationDetailTableViewController
        return toViewController
    }
    
    @IBAction func swipeGesture(_ sender: Any) {
        print("SWIPED")
        let indexPath = IndexPath(row: currentIndex, section: 0)
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
        sideMenuController?.performSegue(withIdentifier: "showCenterController1", sender: nil)
    }
    
    @IBAction func showHome(_ sender: Any) {
        sideMenuController?.performSegue(withIdentifier: "showLiveFeed", sender: nil)
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
    
    func swipeHandler(_ sender: UISwipeGestureRecognizer) {
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



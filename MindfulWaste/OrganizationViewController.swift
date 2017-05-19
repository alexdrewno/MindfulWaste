import UIKit
import expanding_collection

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
    
}



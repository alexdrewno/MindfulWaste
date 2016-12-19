import UIKit
import FirebaseDatabase
import FirebaseAuth


class ReportViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak var collectionView: UICollectionView!
    let categories = ["Fruits", "Vegetables", "Protein", "Dairy", "Grains", "Oils"]
    let colors = [UIColor.red, UIColor.green, UIColor.brown, UIColor.lightGray, UIColor.yellow, UIColor.orange]
    var amount = [0,0,0,0,0,0]
    let ref = FIRDatabase.database().reference(withPath: "reports")
    
    override func viewDidLoad()
    {
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        let width = floor(screenWidth/2 - 16)
        layout.itemSize = CGSize(width:width, height: width)
        collectionView.collectionViewLayout = layout
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    
    @IBAction func showHomeScreen(_ sender: Any)
    {
        sideMenuController?.performSegue(withIdentifier: "showCenterController1", sender: nil)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CustomCollectionCell
        cell.categoryLabel.text! = categories[indexPath.row]
        cell.numberLabel.text! = "\(amount[indexPath.row])"
        cell.categoryLabel.adjustsFontSizeToFitWidth = true
        cell.numberLabel.adjustsFontSizeToFitWidth = true
        cell.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let alert = UIAlertController(title: "Change Amount", message: "How many lbs of \(categories[indexPath.row])?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addTextField { (textField) in
            textField.keyboardType = .numberPad
        }
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action: UIAlertAction) in
            if alert.textFields![0].text != nil
            {
                self.amount[indexPath.row] = Int(alert.textFields![0].text!)!
                self.collectionView.reloadData()
            }
        }))
        present(alert, animated: false)
        
    }

    @IBAction func saveAction(_ sender: Any)
    {
        if FIRAuth.auth()!.currentUser != nil
        {
            let alert = UIAlertController(title: "Save Report", message: "Name your report", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addTextField(configurationHandler: nil)
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_:UIAlertAction) in
                let report = Report(name:alert.textFields![0].text!,f: self.amount[0], v: self.amount[1], p: self.amount[2], d: self.amount[3], g: self.amount[4], o: self.amount[5],user: FIRAuth.auth()!.currentUser!.email!)
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

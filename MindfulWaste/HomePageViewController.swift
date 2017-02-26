import UIKit
import SideMenuController
import Charts
import FirebaseDatabase

class HomePageViewController : UIViewController, SideMenuControllerDelegate
{
    @IBOutlet weak var pieChart: PieChartView!
    let categories = ["Fruits", "Vegetables", "Dry Goods", "Dairy", "Misc."]
    var amountArray = [0,0,0,0,0]
    
    
    var amount = 0
    var fruitsAmount = 0
    var vegetablesAmount = 0
    var dryGoodsAmount = 0
    var dairyAmount = 0
    var miscAmount = 0
    
    override func viewDidLoad() {
        pieChart.backgroundColor = UIColor.clear
        pieChart.animate(xAxisDuration: 1)
        sideMenuController?.delegate = self
        let ref = FIRDatabase.database().reference(withPath: "reports")
        ref.observe(.value, with: { snapshot in
   
            self.dairyAmount = 0
            self.fruitsAmount = 0
            self.vegetablesAmount = 0
            self.dryGoodsAmount = 0
            self.miscAmount = 0
            self.amount = 0

            
            //maybe will crash here, did not test code, *praying that it works*
            
            for child in snapshot.children
            {
                let dict = (child as! FIRDataSnapshot).value as! NSDictionary
                self.dairyAmount += (dict["dairyInformation"] as! NSDictionary)["dairyAmount"]! as! Int
                self.fruitsAmount += (dict["fruitInformation"] as! NSDictionary)["fruitAmount"]! as! Int
                self.vegetablesAmount += (dict["vegetableInformation"] as! NSDictionary)["vegetableAmount"]! as! Int
                self.dryGoodsAmount += (dict["dryGoodsInformation"] as! NSDictionary)["dryGoodsAmount"]! as! Int
                self.miscAmount += (dict["miscInformation"] as! NSDictionary)["miscAmount"]! as! Int
                self.amount = self.dairyAmount + self.fruitsAmount + self.vegetablesAmount + self.miscAmount + self.dryGoodsAmount
                print(self.amount)
            }
            
            
            self.amountArray[0] = self.fruitsAmount
            self.amountArray[1] = self.vegetablesAmount
            self.amountArray[2] = self.dryGoodsAmount
            self.amountArray[3] = self.dairyAmount
            self.amountArray[4] = self.miscAmount
            self.setPieChart(xVals: self.amountArray, yVals: self.categories)
            
        })
    }
    
    
    @IBAction func showLiveFeed(_ sender: AnyObject) {
        sideMenuController?.performSegue(withIdentifier: "showLiveFeed", sender: nil)
    }
    
    public func sideMenuControllerDidHide(_ sideMenuController: SideMenuController) {
        print(#function)
        
    }
    
    func sideMenuControllerDidReveal(_ sideMenuController: SideMenuController) {
        print(#function)
    }
    
    func setPieChart(xVals: [Int], yVals: [String])
    {
        var dataEntries: [PieChartDataEntry] = []
        let colors1 = [UIColor.red, UIColor.green, UIColor.yellow, UIColor.lightGray, UIColor.orange]
        var setColors : [UIColor] = []
        
        for i in 0..<xVals.count {
            if xVals[i] != 0
            {
                let dataEntry = PieChartDataEntry(value: Double(xVals[i]))
                dataEntries.append(dataEntry)
                setColors.append(colors1[i])
                
            }
        }
        
        let chartDataSet = PieChartDataSet(values: dataEntries, label: "Amount Collected")
        let chartData = PieChartData(dataSet: chartDataSet)

        chartDataSet.colors = setColors
        let centerText = NSAttributedString(string: "\(amount)", attributes: [ NSFontAttributeName: UIFont(name: "Futura", size: 36)! ])
        pieChart.centerAttributedText = centerText
        pieChart.data = chartData
    }
    
    
}

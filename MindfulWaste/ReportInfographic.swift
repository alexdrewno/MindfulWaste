import UIKit
import Charts

class ReportInfographic : UIViewController
{
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var mealsSavedLabel: UILabel!
    @IBOutlet weak var c02ReducedLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var mostAmountLabel: UILabel!
    @IBOutlet weak var mostAmountCategoryLabel: UILabel!
    let categories = ["Fruits", "Vegetables", "Dry Goods", "Dairy", "Misc."]
    var amountArray : [CGFloat] = [0.0,0.0,0.0,0.0,0.0]
    
    
    override func viewDidLoad()
    {
        self.automaticallyAdjustsScrollViewInsets = false
        pieChartView.highlightPerTapEnabled = false
        setPieChart(xVals: [10,20,10,10,10], yVals: categories)
    }
    
    func setPieChart(xVals: [CGFloat], yVals: [String])
    {
        var dataEntries: [PieChartDataEntry] = []
        let colors1 = [UIColor(red: 209/255, green: 54/255, blue: 23/255, alpha: 1.0), UIColor(red: 85/255, green: 204/255, blue: 34/255, alpha: 1.0), UIColor(red: 255/255, green: 224/255, blue: 48/255, alpha: 1.0), UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0), UIColor(red: 232/255, green: 174/255, blue: 67/255, alpha: 1.0)]
        var setColors : [UIColor] = []
        
        for i in 0..<xVals.count {
            if xVals[i] != 0
            {
                let dataEntry = PieChartDataEntry(value: Double(xVals[i]))
                dataEntries.append(dataEntry)
                setColors.append(colors1[i])
                
            }
        }
        
        let chartDataSet = PieChartDataSet(values: dataEntries, label: "")
        let chartData = PieChartData(dataSet: chartDataSet)
        
        
        chartDataSet.valueTextColor = UIColor.black
        chartDataSet.valueFont = UIFont(name: "Optima", size: 20)!
        chartDataSet.sliceSpace = 3.0
        pieChartView.drawHoleEnabled = false
        
        chartDataSet.colors = setColors
        pieChartView.chartDescription?.text! = ""
        
        pieChartView.data = chartData
    }

}

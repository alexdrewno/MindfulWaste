import UIKit
import FoldingCell
import Charts
import KDCircularProgress

protocol FoldingCellDelegate {
    func updateInfo(groupName: String, array: [CGFloat])
    func finishedEditing()
}

class ReportCell: FoldingCell, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var leftView: UIView!
    @IBOutlet var groupLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var rightView: UIView!
    @IBOutlet var innerContainer: UIView!
    @IBOutlet var topView: UIView!
    @IBOutlet var categoryContainerLabel: UILabel!
    @IBOutlet var insideTableView: UITableView!
    @IBOutlet weak var targetGoalLabel: UILabel!
    var goal : CGFloat = 100
    var amount : CGFloat = 0
    var color : UIColor = UIColor.white
    var descriptions = [""]
    var amountValues: [CGFloat] = [0]
    var delegate : FoldingCellDelegate? = nil
    @IBOutlet weak var progressCircle: KDCircularProgress!
  
    
    
    
    override func awakeFromNib() {
        insideTableView.separatorStyle = .singleLineEtched
        itemCount = 4
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        innerContainer.layer.cornerRadius = 8
        innerContainer.layer.masksToBounds = true
        backViewColor = UIColor.init(red: 144/255, green: 238/255, blue: 144/255, alpha: 1)
        insideTableView.delegate = self
        insideTableView.dataSource = self
        insideTableView.allowsSelection = false
        insideTableView.backgroundColor = UIColor.clear
        super.awakeFromNib()
        if amountValues.count == 1
        {
            amountValues = [CGFloat](repeating: 0.0, count: descriptions.count)
        }
    }
    
    func updateCircularProgress()
    {
        progressCircle.startAngle = -90
        progressCircle.progressThickness = 0.3
        progressCircle.trackThickness = 0.5
        progressCircle.clockwise = true
        progressCircle.gradientRotateSpeed = 2
        progressCircle.roundedCorners = true
        progressCircle.glowMode = .forward
        progressCircle.glowAmount = 0.9
        print(amount,"amount")
        if amount/goal >= 1.0
        {
            progressCircle.angle = 360
        }
        else
        {
            progressCircle.angle = Double(( amount / goal ) * 360)
        }
    }
    
    func updateChartWithData() {
        var dataEntries: [BarChartDataEntry] = []
        var randoColors = [UIColor.red, UIColor.green, UIColor.yellow, UIColor.lightGray, UIColor.orange]
        var colors : [UIColor] = []
        
        for i in 0..<descriptions.count {

            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(amountValues[i]))
            dataEntries.append(dataEntry)
            colors.append(randoColors[Int(arc4random() % 5)])
            
            
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Details")
        chartDataSet.colors = colors
        let chartData = BarChartData(dataSet: chartDataSet)
        //barChartView.data = chartData
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return descriptions.count+1
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0
        {
            return 50
        }
        else
        {
            return 75
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = insideTableView.dequeueReusableCell(withIdentifier: "detailedReportCell") as! DetailedReportCell
        cell.cellView.backgroundColor = color
        if amountValues.count == 1
        {
            amountValues = [CGFloat](repeating: 0.0, count: descriptions.count)
        }
        if indexPath.row > 0
        {
            cell.details.text = descriptions[indexPath.row-1]
            cell.amount.text = "\(amountValues[indexPath.row-1])"
            cell.amount.isEnabled = true
        }
        else
        {
            cell.amount.isEnabled = false
        }
        return cell
    }
    
    
    @IBAction func editingFinished(_ sender: AnyObject)
    {
        //delegate?.finishedEditing()
    }
    
    @IBAction func editingChanged(_ sender: AnyObject) {
        
        var superview = sender.superview!
        
        while superview != nil
        {
            if let superview = superview as? DetailedReportCell
            {
                let indexPath = insideTableView.indexPath(for: superview)!
                let cell = (insideTableView.cellForRow(at: indexPath) as! DetailedReportCell)
                cell.amount.keyboardType = .numberPad
                amountValues[indexPath.row-1] = CGFloat(((insideTableView.cellForRow(at: indexPath) as! DetailedReportCell).amount.text! as! NSString).doubleValue)
                
                print(amountValues)
                
                //save the amount to the rootviewcontroller lmao
                
                switch groupLabel.text!
                {
                case "Fruits":
                    delegate?.updateInfo(groupName: "Fruits", array: amountValues)
                    print("updateFruits")
                case "Vegetables":
                    delegate?.updateInfo(groupName: "Vegetables", array: amountValues)
                case "Dry Goods":
                    delegate?.updateInfo(groupName: "Dry Goods", array: amountValues)
                case "Dairy":
                    delegate?.updateInfo(groupName: "Dairy", array: amountValues)
                case "Misc.":
                    delegate?.updateInfo(groupName: "Misc.", array: amountValues)
                default:
                    break
                }
                
                break
            }
            else
            {
                superview = superview?.superview
            }
        }

        
    }
    
    override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
        
        let durations = [0.26, 0.2, 0.2, 0.2, 0.2]
        return durations[itemIndex]
    }
}


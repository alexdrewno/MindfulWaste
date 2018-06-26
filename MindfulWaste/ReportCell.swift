import UIKit
import FoldingCell
import Charts
import KDCircularProgress

protocol FoldingCellDelegate {
    func updateInfo(groupName: String, array: [CGFloat])
    func finishedEditing()
    func updateNumber(groupName: String, array: [CGFloat])
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
    var numberValues: [CGFloat] = [0]
    var delegate : FoldingCellDelegate? = nil
    @IBOutlet weak var cellCategories: UILabel!
  
    
    
    
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
        if numberValues.count == 1
        {
            numberValues = [CGFloat](repeating: 0.0, count: descriptions.count)
        }
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
            numberValues = [CGFloat](repeating: 0.0, count: descriptions.count)
        }
        if indexPath.row > 0
        {
            cell.details.text = descriptions[indexPath.row-1]
            cell.amount.text = "\(amountValues[indexPath.row-1])"
            cell.number.text = "\(numberValues[indexPath.row-1])"
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
                amountValues[indexPath.row-1] = CGFloat(((insideTableView.cellForRow(at: indexPath) as! DetailedReportCell).amount.text! as NSString).doubleValue)
                numberValues[indexPath.row-1] = CGFloat(((insideTableView.cellForRow(at: indexPath) as! DetailedReportCell).number.text! as NSString).doubleValue)
                print(amountValues)
                
                //save the amount to the rootviewcontroller lmao
                
                switch groupLabel.text!
                {
                case "Fruits":
                    delegate?.updateInfo(groupName: "Fruits", array: amountValues)
                    delegate?.updateNumber(groupName: "Fruits", array: numberValues)
                case "Vegetables":
                    delegate?.updateInfo(groupName: "Vegetables", array: amountValues)
                    delegate?.updateNumber(groupName: "Vegetables", array: numberValues)
                case "Dry Goods":
                    delegate?.updateInfo(groupName: "Dry Goods", array: amountValues)
                    delegate?.updateNumber(groupName: "Dry Goods", array: numberValues)
                case "Dairy":
                    delegate?.updateInfo(groupName: "Dairy", array: amountValues)
                    delegate?.updateNumber(groupName: "Dairy", array: numberValues)
                case "Misc.":
                    delegate?.updateInfo(groupName: "Misc.", array: amountValues)
                    delegate?.updateNumber(groupName: "Misc", array: numberValues)
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


import UIKit
import FoldingCell

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
    var color : UIColor = UIColor.white
    var descriptions = [""]
  
    
    
    
    override func awakeFromNib() {
        insideTableView.separatorStyle = .singleLineEtched
        insideTableView.backgroundColor = UIColor.clear
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
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return descriptions.count+1
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0
        {
            return 70
        }
        else
        {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = insideTableView.dequeueReusableCell(withIdentifier: "detailedReportCell") as! DetailedReportCell
        cell.cellView.backgroundColor = color
        if indexPath.row > 0
        {
            cell.details.text = descriptions[indexPath.row-1]
        }
        return cell
    }
    
    override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
        
        let durations = [0.26, 0.2, 0.2, 0.2, 0.2]
        return durations[itemIndex]
    }
}


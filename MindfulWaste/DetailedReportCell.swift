import UIKit

class DetailedReportCell: UITableViewCell
{
    
    @IBOutlet var details: UILabel!
    @IBOutlet var amount: UILabel!
    @IBOutlet var cellView: UIView!
    
    override func awakeFromNib() {
        backgroundColor = UIColor.clear
    }
}

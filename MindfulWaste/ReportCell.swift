import UIKit
import FoldingCell

class ReportCell: FoldingCell
{
    
    override func awakeFromNib() {
        itemCount = 4
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        backViewColor = UIColor.init(red: 144/255, green: 238/255, blue: 144/255, alpha: 1)
        
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
        
        let durations = [0.26, 0.2, 0.2, 0.2, 0.2]
        return durations[itemIndex]
    }
}

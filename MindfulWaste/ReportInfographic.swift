import UIKit

class ReportInfographic : UIViewController
{
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad()
    {
        scrollView.contentSize.height = 1200
    }
}

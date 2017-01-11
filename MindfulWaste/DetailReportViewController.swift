import UIKit

class DetailReportViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var category = ""
    @IBOutlet var tableView: UITableView!
    @IBOutlet var detailLabel: UILabel!
    
    
    override func viewDidLoad() {
        detailLabel.text = "Detailed Report of \(category)"
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
}

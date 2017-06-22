import UIKit
import FirebaseDatabase
import Material
import FirebaseAuth

class NewOrganizationViewController: UIViewController, TextFieldDelegate
{
    fileprivate var nameField: ErrorTextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    let ref = Database.database().reference(withPath: "organizations")
    let defaults = UserDefaults()
    
    override func viewDidLoad() {
        
        setupNameField()
        
    }
    
    func setupNameField()
    {
        nameField = ErrorTextField()
        nameField.placeholder = "Organization Name"
        nameField.tag = 1
        nameField.detail = "Error, organization name is already taken."
        nameField.isClearIconButtonEnabled = true
        nameField.delegate = self
        nameField.font = UIFont(name: "Gill Sans", size: 18)
        
        
        view.layout(nameField).top(view.height/5).left(20).right(20)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        let date2 = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let date = formatter.string(from: date2)
        let newOrg = Organization(c: self.defaults.value(forKey: "user") as! String, dc: date, name: nameField.text!, d: descriptionTextView.text!)
        let userRef = self.ref.child(nameField.text!)
        userRef.setValue(newOrg.toAnyObject())
        
        self.navigationController?.popViewController(animated: true)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        
//        switch textField.tag
//        {
//        case 1:
//            if let a = textField.text?.contains("@")
//            {
//                if !a
//                {
//                    (textField as? ErrorTextField)?.isErrorRevealed = true
//                }
//                else
//                {
//                    (textField as? ErrorTextField)?.isErrorRevealed = false
//                }
//            }
//        default:
//            break
//        }
        
    }
    
    
}

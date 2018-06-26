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
    var organizations = [String]()
    
    override func viewDidLoad() {
        
        setupNameField()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewOrganizationViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        if let email = Auth.auth().currentUser?.email
        {
            let ref = Database.database().reference()
            
            ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
                for child in snapshot.children
                {
                    let dict = (child as! DataSnapshot).value as! NSDictionary
                    if let email2 = dict["email"] as? String
                    {
                        if email2 == email
                        {
                            let dict2 = ((child as! DataSnapshot).value as! NSDictionary)
                            self.organizations = dict2["organization"] as! [String]
                            
                        }
                    }
                }
            }){ (error) in
                print(error.localizedDescription)
            }
        }
        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
        
        
        view.layout(nameField).top(view.frame.height/5).left(20).right(20)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        let date2 = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let date = formatter.string(from: date2)
        let newOrg = Organization(c: self.defaults.value(forKey: "user") as! String, dc: date, name: nameField.text!, d: descriptionTextView.text!, usersInOrg: [(Auth.auth().currentUser?.email!)!])
        let userRef = self.ref.child(nameField.text!)
        userRef.setValue(newOrg.toAnyObject())
        let ref2 = Database.database().reference(withPath: "users/\(self.defaults.value(forKey: "user")!)/organization")
        organizations.append(nameField.text!)
        ref2.setValue(organizations)
        
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

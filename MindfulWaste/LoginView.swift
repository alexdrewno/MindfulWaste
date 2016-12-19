import UIKit
import Firebase
import FirebaseAuth

class LoginView : UIViewController
{
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var containerView: UIView!
    @IBOutlet var popupView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet var button: UIButton!
    var senderVC : MenuController!
    
    override func viewDidLoad()
    {
        textFields[1].isSecureTextEntry = true
        textFields[2].isSecureTextEntry = true
        textFields[2].removeFromSuperview()
        

    }
    
    
    @IBAction func signupDidTouch(_ sender: AnyObject)
    {
        if button.titleLabel?.text == "Don't have an account already? Sign-up"
        {

            self.popupView.addSubview(textFields[2])
            button.setTitle("Already have an account? Log-in", for: .normal)
            loginButton.setTitle("Sign-up", for: .normal)
        }
        else if button.titleLabel?.text == "Already have an account? Log-in"
        {
            textFields[2].removeFromSuperview()
            button.setTitle("Don't have an account already? Sign-up", for: .normal)
            loginButton.setTitle("Log-in", for: .normal)
        }
    }
    
    @IBAction func cancel(_ sender: AnyObject)
    {
        self.senderVC.unwindFromSecondary()
        self.dismiss(animated: true)

        
    }

    @IBAction func loginAction(_ sender: Any)
    {
        if loginButton.titleLabel?.text == "Sign-up"
        {
            if textFields[0].hasText && textFields[1].hasText && textFields[2].text! == textFields[1].text!
            {
                FIRAuth.auth()?.createUser(withEmail: textFields[0].text!, password: textFields[1].text!, completion: { (user:FIRUser?, error:Error?) in
                        if error == nil
                        {
                            FIRAuth.auth()?.signIn(withEmail: self.textFields[0].text!, password: self.textFields[1].text!, completion: { (user: FIRUser?, error: Error?) in
                                    self.senderVC.unwindFromSecondary()
                                    self.senderVC.tableView.reloadData()
                                    self.dismiss(animated: true, completion: nil)
                            })
                        }
                        else
                        {
                            let alertVC = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                            alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                            self.present(alertVC, animated: false)
                        }
                    })
            }
        }
        else
        {
            if textFields[0].hasText && textFields[1].hasText 
            {
                FIRAuth.auth()?.signIn(withEmail: self.textFields[0].text!, password: self.textFields[1].text!, completion: { (user: FIRUser?, error: Error?) in
                        self.senderVC.unwindFromSecondary()
                        self.senderVC.tableView.reloadData()
                        self.dismiss(animated: true, completion: nil)
                    })
            }
        }
        
    }
 
}

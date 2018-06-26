import UIKit
import Material
import FirebaseAuth
import FirebaseDatabase

class LoginMainViewController: UIViewController, TextFieldDelegate
{
    fileprivate var emailField: ErrorTextField!
    fileprivate var passwordField: TextField!
    
    /// A constant to layout the textFields.
    fileprivate let constant: CGFloat = 32
    let defaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preparePasswordField()
        prepareEmailField()
        
        
    }
    

    
    fileprivate func prepareEmailField() {
        emailField = ErrorTextField()
        emailField.tag = 1
        emailField.placeholder = "Email"
        emailField.detail = "Error, incorrect email"
        emailField.isClearIconButtonEnabled = true
        emailField.delegate = self
        emailField.font = UIFont(name: "Gill Sans", size: 15)
        
        // Set the colors for the emailField, different from the defaults.
        //        emailField.placeholderNormalColor = Color.amber.darken4
        //        emailField.placeholderActiveColor = Color.pink.base
        //        emailField.dividerNormalColor = Color.cyan.base
        //        emailField.dividerActiveColor = Color.green.base
        
//        let leftView = UIImageView()
//        //leftView.image = Icon.cm.audio
//        emailField.leftView = leftView
        view.layout(emailField).center(offsetY: -passwordField.frame.height - 40).left(20).right(20)
    }
    
    fileprivate func preparePasswordField() {
        passwordField = TextField()
        passwordField.placeholder = "Password"
        passwordField.detail = "At least 8 characters"
        passwordField.clearButtonMode = .whileEditing
        passwordField.isVisibilityIconButtonEnabled = true
        passwordField.font = UIFont(name: "Gill Sans", size: 15)
        
        // Setting the visibilityIconButton color.
        passwordField.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(passwordField.isSecureTextEntry ? 0.38 : 0.54)
        
        view.layout(passwordField).center().left(20).right(20)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) in
            if error == nil
            {
    
                Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) in
                    //self.performSegue(withIdentifier: "beginningSegue2", sender: nil)
                    //let vc = self.storyboard?.instantiateViewController(withIdentifier: "firstVC") as! ViewController
                    
            
                    
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "firstVC")
                    self.present(vc!, animated: true, completion: nil)
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
    
    
    public func textFieldDidEndEditing(_ textField: UITextField) {


        switch textField.tag
        {
            case 1:
                if let a = textField.text?.contains("@")
                {
                    if !a
                    {
                        (textField as? ErrorTextField)?.isErrorRevealed = true
                    }
                    else
                    {
                        (textField as? ErrorTextField)?.isErrorRevealed = false
                    }
            }                default:
                break
        }

    }

    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = false
        return true
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = false
        return true
    }


}


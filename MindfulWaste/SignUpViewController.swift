import UIKit
import Material
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController : UIViewController, TextFieldDelegate
{
    fileprivate var emailField: ErrorTextField!
    fileprivate var passwordField: TextField!
    fileprivate var confirmPasswordField : ErrorTextField!
    fileprivate var firstNameField: TextField!
    fileprivate var lastNameField : TextField!
    var gender = ""
    
    let imgView2 = UIImageView(image: UIImage(named: "femaleImage"))
    let imgView = UIImageView(image: UIImage(named: "maleImage"))
    
    let ref = Database.database().reference(withPath: "users")
    let defaults = UserDefaults()
    
    /// A constant to layout the textFields.
    fileprivate let constant: CGFloat = 32
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        preparePasswordField()
        prepareConfirmPasswordField()
        prepareEmailField()
        prepareFirstNameField()
        prepareLastNameField()
        prepareGenderImageViews()
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    fileprivate func prepareEmailField() {
        emailField = ErrorTextField()
        emailField.placeholder = "Email"
        emailField.tag = 1
        emailField.detail = "Error, must be a valid email"
        emailField.isClearIconButtonEnabled = true
        emailField.delegate = self
        emailField.font = UIFont(name: "Gill Sans", size: 15)

        
        view.layout(emailField).top(view.frame.height/7).left(20).right(20)
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
        
        view.layout(passwordField).top(view.frame.height/7 * 2).left(20).right(20)
    }
    
    fileprivate func prepareConfirmPasswordField() {
        confirmPasswordField = ErrorTextField()
        confirmPasswordField.tag = 2
        confirmPasswordField.placeholder = "Confirm Password"
        confirmPasswordField.detail = "Passwords must match"
        confirmPasswordField.isVisibilityIconButtonEnabled = true
        confirmPasswordField.delegate = self
        confirmPasswordField.font = UIFont(name: "Gill Sans", size: 15)
        
        confirmPasswordField.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(passwordField.isSecureTextEntry ? 0.38 : 0.54)
        
        view.layout(confirmPasswordField).top(view.frame.height/7 * 3).left(20).right(20)
    }
    
    fileprivate func prepareFirstNameField(){
        firstNameField = TextField()
        firstNameField.placeholder = "First Name"
        firstNameField.clearButtonMode = .whileEditing
        firstNameField.font = UIFont(name: "Gill Sans", size: 15)
        
        view.layout(firstNameField).top(view.frame.height/7 * 4 - 10).left(20).width(view.frame.width/2.5)
    }
    
    fileprivate func prepareLastNameField(){
        lastNameField = TextField()
        lastNameField.placeholder = "Last Name"
        lastNameField.clearButtonMode = .whileEditing
        lastNameField.font = UIFont(name: "Gill Sans", size: 15)
        
        view.layout(lastNameField).top(view.frame.height/7 * 4 - 10).right(20).width(view.frame.width/2.5)
    }
    
    func prepareGenderImageViews()
    {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap1(_:)))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap2(_:)))
        
        
        
        
        imgView2.isUserInteractionEnabled = true
        imgView.isUserInteractionEnabled = true
        

        imgView.frame = CGRect(x: 100, y: 100, width: Int(view.frame.width/3), height: Int(view.frame.height/5))
        imgView.alpha = 0.75
        
        imgView.addGestureRecognizer(tap)
        imgView2.addGestureRecognizer(tap2)
        
        view.layout(imgView).top(view.frame.height/7 * 4.8).left(view.frame.width/7).width(view.frame.width/5.5).height(view.frame.height/5.5)
        

        imgView2.frame = CGRect(x: 100, y: 100, width: Int(view.frame.width/3), height: Int(view.frame.height/5))
        imgView2.alpha = 0.75
        
        view.layout(imgView2).top(view.frame.height/7 * 4.8).right(view.frame.width/7).width(view.frame.width/4.5).height(view.frame.height/5)
        
      
    }
    
    
    
    @objc func handleTap1(_ sender: UITapGestureRecognizer) {
        
        print("tapped")
        UIView.animate(withDuration: 0.5) { 
            self.imgView.alpha = 1
            self.imgView2.alpha = 0.35
            self.gender = "m"
        }

    }
    
    @objc func handleTap2(_ sender: UITapGestureRecognizer) {
        
        print("tapped")
        UIView.animate(withDuration: 0.5) {
            self.imgView.alpha = 0.35
            self.imgView2.alpha = 1
            self.gender = "f"
        }
        
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        if !emailField.text!.isEmpty && !passwordField.text!.isEmpty && !confirmPasswordField.text!.isEmpty && !firstNameField.text!.isEmpty && !lastNameField.text!.isEmpty && !confirmPasswordField.isErrorRevealed && !emailField.isErrorRevealed
        {
            print("everything is filled out and no errors")
            
            let newUser = MindfulWasteUser(email: self.emailField.text!, firstName: self.firstNameField.text!, lastName: self.lastNameField.text!, gender: self.gender)
            
            Auth.auth().createUser(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) in
                if error == nil
                {
                    Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) in
                        print("worked and signed in")
                        //self.performSegue(withIdentifier: "beginningSegue", sender: nil)
                        
                        let userRef = self.ref.child(self.firstNameField.text! + " " + self.lastNameField.text!)
                        self.defaults.set(self.firstNameField.text! + " " + self.lastNameField.text!, forKey: "user")
                        userRef.setValue(newUser.toAnyObject())
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
            }
        case 2:
            if !(textField.text! == passwordField.text!)
            {
                (textField as? ErrorTextField)?.isErrorRevealed = true
            }
        default:
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

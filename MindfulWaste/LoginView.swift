import UIKit
import Firebase

class LoginView : UIViewController
{
    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var popupView: UIView!
    
    @IBOutlet var button: UIButton!
    
    var senderVC : MenuController!
    
    override func viewDidLoad()
    {
        textFields[2].removeFromSuperview()

    }
    
    
    @IBAction func signupDidTouch(_ sender: AnyObject)
    {
        if button.titleLabel?.text == "Don't have an account already? Sign-up"
        {

            self.popupView.addSubview(textFields[2])
            button.setTitle("Already have an account? Log-in", for: .normal)
        }
        else if button.titleLabel?.text == "Already have an account? Log-in"
        {
            textFields[2].removeFromSuperview()
            button.setTitle("Don't have an account already? Sign-up", for: .normal)
        }
    }
    
    @IBAction func cancel(_ sender: AnyObject)
    {
        self.senderVC.unwindFromSecondary()
        self.dismiss(animated: true) { 
            
        }

        
    }
 
}

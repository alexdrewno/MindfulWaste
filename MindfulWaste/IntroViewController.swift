import UIKit
import FirebaseAuth

class IntroViewController: UIViewController
{
    override func viewDidLoad() {
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if FIRAuth.auth()?.currentUser != nil
        {
            performSegue(withIdentifier: "skipLogin", sender: nil)
            print(1)
        }
        else{
            performSegue(withIdentifier: "firstSegue", sender: nil)
            print(2)
        }
    }
}

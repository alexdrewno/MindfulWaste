import UIKit
import FirebaseAuth

class IntroViewController: UIViewController
{
    override func viewDidLoad() {
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(Auth.auth().currentUser)
        if Auth.auth().currentUser != nil
        {
            performSegue(withIdentifier: "skipLogin", sender: nil)
        }
        else{
            performSegue(withIdentifier: "firstSegue", sender: nil)
        }
    }
}

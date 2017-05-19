import UIKit
import FirebaseAuth

class IntroViewController: UIViewController
{
    override func viewDidLoad() {
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        do {
           try Auth.auth().signOut()
            print("successfulsignout")
        }
        catch
        {
            print(error.localizedDescription)
        }
        if Auth.auth().currentUser != nil
        {
            performSegue(withIdentifier: "skipLogin", sender: nil)
        }
        else{
            performSegue(withIdentifier: "firstSegue", sender: nil)
        }
    }
}

//
//  ViewController.swift
//  MindfulWaste
//
//  Created by adrewno1 on 12/6/16.
//  Copyright © 2016 adrewno1. All rights reserved.
//

import UIKit
import SideMenuController
import FirebaseDatabase
import FirebaseAuth

class ViewController: SideMenuController {
    
    let defaults = UserDefaults()

    override func viewDidLoad()
    {
        super.viewDidLoad()
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
                            self.defaults.setValue("\(dict2["firstName"] as! String) \(dict2["lastName"] as! String)", forKey: "user")
                            print("\(dict2["firstName"] as! String) \(dict2["lastName"] as! String)")
                            print(self.defaults.value(forKey: "user"))
                        }
                    }
                }
            }){ (error) in
                print(error.localizedDescription)
            }
        }
        
        performSegue(withIdentifier: "showCenterController1", sender: nil)
        performSegue(withIdentifier: "containsSideMenu", sender: nil)
        
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        SideMenuController.preferences.drawing.menuButtonImage = UIImage(named: "menu")
        SideMenuController.preferences.drawing.sidePanelPosition = .overCenterPanelLeft
        SideMenuController.preferences.drawing.sidePanelWidth = 200
        SideMenuController.preferences.drawing.centerPanelShadow = true
        SideMenuController.preferences.animating.statusBarBehaviour = .showUnderlay
        super.init(coder: aDecoder)
    }



}


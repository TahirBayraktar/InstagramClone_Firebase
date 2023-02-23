//
//  SettingsViewController.swift
//  InstagramFirebase
//
//  Created by Tahir Bayraktar on 24.02.2023.
//

import UIKit
import FirebaseAuth
class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
        }catch{
            print("error!")
        }
        
        
    }
    
}

//
//  ViewController.swift
//  InstagramFirebase
//
//  Created by Tahir Bayraktar on 22.02.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


   
    @IBAction func signInClicked(_ sender: Any) {
        if emailText.text! != "" && passwordText.text! != ""{
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authdataresult, error in
                if error != nil{
                    self.makeAlert(tittleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }else{
            makeAlert(tittleInput: "Error!", messageInput: "Usarname/Password ?")
        }
    }
    @IBAction func signUpClicked(_ sender: Any) {
        if  emailText.text != "" && passwordText.text != ""{
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) {AuthDataResult, error in
                if error != nil{
                    self.makeAlert(tittleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
            }
        else{
            makeAlert(tittleInput: "Error!", messageInput: "Usarname/Password ?")
        }
        
    }
//    Alert Message
    func makeAlert(tittleInput:String , messageInput:String){
        let alert = UIAlertController(title:tittleInput , message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert,animated: true,completion: nil)
    }
}


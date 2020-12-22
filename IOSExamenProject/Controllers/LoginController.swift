//
//  LoginController.swift
//  IOSExamenProject
//
//  Created by Kaan Calli on 22/12/2020.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {


    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.text = "Test123@mail.com"
        passwordTextField.text = "P@ssword1111"
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    //self.performSegue(withIdentifier: K.loginSegue, sender: self)
                    print("succesfully logged in!")
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let shoppingListController = storyboard.instantiateViewController(identifier: "NavigationController")
                        
                        // This is to get the SceneDelegate object from your view controller
                        // then call the change root view controller function to change to main tab bar
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(shoppingListController)


                }
            }
        }
    }
}

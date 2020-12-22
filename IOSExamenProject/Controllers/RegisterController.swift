//
//  RegisterController.swift
//  IOSExamenProject
//
//  Created by Kaan Calli on 22/12/2020.
//

import UIKit
import Firebase

class RegisterController: UIViewController {
    
  
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    //Navigate to the ChatViewController
                    print("succesfully registered !")
                    
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


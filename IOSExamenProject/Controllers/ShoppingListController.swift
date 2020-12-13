//
//  ShoppingListController.swift
//  IOSExamenProject
//
//  Created by Kaan Calli on 07/12/2020.
//

import UIKit
import CoreData

class ShoppingListController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    }


}

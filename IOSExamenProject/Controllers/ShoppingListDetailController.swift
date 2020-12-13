//
//  ShoppingListDetailController.swift
//  IOSExamenProject
//
//  Created by Kaan Calli on 13/12/2020.
//

import UIKit
import CoreData

class ShoppingListDetailController: UIViewController {
    
    @IBOutlet weak var groceryNameLabel: UILabel!
    
    @IBOutlet weak var groceriesTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var groceries = [String]()
    
    var selectedGrocery : GroceryList? {
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groceriesTableView.dataSource = self
        groceriesTableView.delegate = self
        
        groceryNameLabel.text = selectedGrocery?.name
    }
    
    
    
    @IBAction func editShoppingList(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "groceryDetailToEdit", sender: self)

        
    }
    
    
}

extension ShoppingListDetailController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "groceryDetailToEdit" {

    
            let destinationVC = segue.destination as! EditShoppingListController
        
            destinationVC.selectedGrocery = selectedGrocery
        
        }
 
    }
    
}

extension ShoppingListDetailController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceries.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryCell", for: indexPath)
        //cell.textLabel?.text = groceries[indexPath.row].name
        
        return cell
    }
    
    
}



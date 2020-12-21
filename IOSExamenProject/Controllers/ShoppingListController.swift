//
//  ShoppingListController.swift
//  IOSExamenProject
//
//  Created by Kaan Calli on 07/12/2020.
//

import UIKit
import CoreData

class ShoppingListController: UIViewController {

    @IBOutlet weak var groceryTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var groceries = [GroceryList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        groceryTableView.dataSource = self
        groceryTableView.delegate = self
        
        
        fetchGroceryList()
        
       
        
    }
    
 
    func saveGroceries() {
        do {
            try context.save()
        } catch {
            print("Error saving recipe \(error)")
        }
        
        self.groceryTableView.reloadData()
        
    }
    func fetchGroceryList(){
        
        do {
            self.groceries = try context.fetch(GroceryList.fetchRequest())
            DispatchQueue.main.async {
                self.groceryTableView.reloadData()
            }
            
        }catch{
            
        }
        
    }
    @IBAction func addGroceryList(_ sender: UIButton) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ShoppingList", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newGroceryList = GroceryList(context: self.context)
            newGroceryList.name = textField.text!
            
            self.groceries.append(newGroceryList)
            
            self.saveGroceries()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new Grocerylist"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
}


extension ShoppingListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        performSegue(withIdentifier: "groceryListToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "groceryListToDetail" {
         let destinationVC = segue.destination as! ShoppingListDetailController
            if let indexPath = groceryTableView.indexPathForSelectedRow{
                destinationVC.selectedGrocery = groceries[indexPath.row]
            }
        }else {
            _ = segue.destination as! RecipeListController
        }
        
        
 
    }
}

extension ShoppingListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceries.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryCell", for: indexPath)
        cell.textLabel?.text = groceries[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action,view,completionHandler) in
            
            let groceryToRemove = self.groceries[indexPath.row]
            
            self.context.delete(groceryToRemove)

            self.saveGroceries();
           
            self.fetchGroceryList()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
}

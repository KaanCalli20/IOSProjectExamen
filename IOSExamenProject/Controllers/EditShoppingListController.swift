//
//  EditShoppingListController.swift
//  IOSExamenProject
//
//  Created by Kaan Calli on 13/12/2020.
//

import UIKit
import CoreData

class EditShoppingListController: UIViewController {
    
    
    @IBOutlet weak var recipeTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var recipes = [Recipe]()
    
    var selectedGrocery : GroceryList? {
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        recipeTableView.dataSource = self
        recipeTableView.delegate = self
        fetchRecipes()
        
    }
    func fetchRecipes(){
        
        do {
            self.recipes = try context.fetch(Recipe.fetchRequest())
            DispatchQueue.main.async {
                self.recipeTableView.reloadData()
            }
        }catch{
            
        }
        
    }
    
    func saveRecipes() {
        do {
            try context.save()
        } catch {
            print("Error saving recipe \(error)")
        }
        
        self.recipeTableView.reloadData()
        
    }
    
}



extension EditShoppingListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    
    }
}

extension EditShoppingListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        cell.textLabel?.text = recipes[indexPath.row].name
        
        return cell
    }
    
    
}

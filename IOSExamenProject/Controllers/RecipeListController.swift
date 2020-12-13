//
//  RecipeListController.swift
//  IOSExamenProject
//
//  Created by Kaan Calli on 12/12/2020.
//

import UIKit
import CoreData

class RecipeListController: UIViewController {

    @IBOutlet weak var recepiTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var recipes = [Recipe]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        recepiTableView.dataSource = self
        recepiTableView.delegate = self
        fetchRecipes()
        
    }
    
    func fetchRecipes(){
        
        do {
            self.recipes = try context.fetch(Recipe.fetchRequest())
            DispatchQueue.main.async {
                self.recepiTableView.reloadData()
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
        
        self.recepiTableView.reloadData()
        
    }

    @IBAction func addRecipeButton(_ sender: UIButton) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Recipe", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newRecipe = Recipe(context: self.context)
            newRecipe.name = textField.text!
            
            self.recipes.append(newRecipe)
            
            self.saveRecipes()
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new Recipe"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension RecipeListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        performSegue(withIdentifier: "recipeListToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! RecipeDetailController
        
        if let indexPath = recepiTableView.indexPathForSelectedRow{
            destinationVC.geselecteerdeRecept = recipes[indexPath.row]
        }
    }
}

extension RecipeListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        cell.textLabel?.text = recipes[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action,view,completionHandler) in
            
            let recipeToRemove = self.recipes[indexPath.row]
            
            self.context.delete(recipeToRemove)

            self.saveRecipes();
           
            self.fetchRecipes()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
}

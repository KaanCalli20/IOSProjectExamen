//
//  RecipeDetailController.swift
//  IOSExamenProject
//
//  Created by Kaan Calli on 13/12/2020.
//

import UIKit
import CoreData

class RecipeDetailController: UIViewController {

    
    @IBOutlet weak var receptNaamLabel: UILabel!

    @IBOutlet weak var ingredientTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var ingredients = [Ingredient]()
    
    var geselecteerdeRecept : Recipe? {
        didSet{
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientTableView.dataSource = self
        ingredientTableView.delegate = self
        
        receptNaamLabel.text = geselecteerdeRecept?.name
        
    }
    
    func loadItems(with request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest(), predicate: NSPredicate? = nil) {
                
        ingredients = geselecteerdeRecept?.ingredients?.allObjects as! [Ingredient]
        
    }
    
    func saveIngredient() {
        do {
            try context.save()
        } catch {
            print("Error saving ingredients \(error)")
        }
        DispatchQueue.main.async {
        self.ingredientTableView.reloadData()
        }
    }

    @IBAction func addIngredientButton(_ sender: UIButton) {
        var ingredientNameText = UITextField()
        var ingredientAmountText = UITextField()
        
        let alert = UIAlertController(title: "Add New Ingredient", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newIngredient = Ingredient(context: self.context)
            newIngredient.name = ingredientNameText.text!
            newIngredient.amount = Int16(ingredientAmountText.text!) as NSNumber?
            
            self.geselecteerdeRecept?.addToIngredients(newIngredient)
            
            self.ingredients.append(newIngredient)
            
            self.saveIngredient()
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            ingredientNameText = field
            ingredientNameText.placeholder = "Add a name "
        }
        alert.addTextField{ (field) in
            ingredientAmountText = field
            ingredientAmountText.placeholder = "Add a amount"
            ingredientAmountText.keyboardType = .decimalPad
        }
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension RecipeDetailController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension RecipeDetailController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        cell.textLabel?.text = ingredients[indexPath.row].toString()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action,view,completionHandler) in
            
            let ingredientToRemove = self.ingredients[indexPath.row]
            
            self.geselecteerdeRecept?.removeFromIngredients(ingredientToRemove)

            self.saveIngredient();
           
            self.loadItems()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
}


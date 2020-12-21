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
    var selectedRecipes = [Recipe]()
    
    var selectedGrocery : GroceryList? {
        didSet{
            selectedGrocery?.recipes?.forEach({ (rec) in
                let recipe = rec as! Recipe
                selectedRecipes.append(recipe)
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        recipeTableView.dataSource = self
        recipeTableView.delegate = self
        
        self.recipeTableView.allowsMultipleSelection = true
        self.recipeTableView.allowsMultipleSelectionDuringEditing = true
        
        
        fetchRecipes()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //fetchSelectedRecipes()
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
    
    func fetchSelectedRecipes(){
        selectedGrocery?.recipes?.forEach({ (rec) in
                let index = recipes.firstIndex(of: rec as!Recipe)
                let indexpath = IndexPath(row: index!, section: 0)
                recipeTableView.selectRow(at: indexpath, animated: true, scrollPosition: .top)
            
        })
    }
    
    func saveRecipes() {
        do {
            try context.save()
        } catch {
            print("Error saving recipe \(error)")
        }
        
        
    }
    
    @IBAction func saveSelectedRecipes(_ sender: UIButton) {
        
        print("test1")
        
        for a in selectedRecipes {
            print(a.name)
        }
        
        for recipe in recipes {
            if(selectedGrocery!.recipes!.contains(recipe)){
                selectedGrocery?.removeFromRecipes(recipe)
            }
            if selectedGrocery?.recipes?.count == 0 {
                break
            }
        }
        
        
        if selectedRecipes.count > 0{
            for recipe in selectedRecipes {
                selectedGrocery?.addToRecipes(recipe)
            }
        }
        
        saveRecipes()
        
        
        
        _ = navigationController?.popViewController(animated: true)
    }
}



extension EditShoppingListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedRecipe = self.recipes[indexPath.row]
        self.selectedRecipes.append(selectedRecipe)
        
        for i in selectedRecipes {
            print(i.name!)
        }
        
    }
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        print(indexPath)
        
        let deSelectedRecipe = self.recipes[indexPath.row]
        let index = self.selectedRecipes.firstIndex(of:deSelectedRecipe)
        if index != nil{
            self.selectedRecipes.remove(at: index!);

        }
        for i in selectedRecipes {
            print(i.name!)
        }
        return indexPath
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        selectedGrocery?.recipes?.forEach({ (rec) in
            let recipe = (rec as! Recipe)
            if recipe.name == cell.textLabel?.text {
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
            }
        })
    }
    
}

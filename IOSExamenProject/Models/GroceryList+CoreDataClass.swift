//
//  GroceryList+CoreDataClass.swift
//  IOSExamenProject
//
//  Created by Kaan Calli on 13/12/2020.
//
//

import Foundation
import CoreData

@objc(GroceryList)
public class GroceryList: NSManagedObject {

    func toList() -> [String] {
        
        var groceries = [String]()
        var amounts = [Int]()
        var finalList = [String]()
        recipes?.forEach({ (rec) in
            let recipe = (rec as! Recipe)
            recipe.ingredients?.forEach({ (ing) in
                let ingredient = (ing as! Ingredient)
                    if groceries.contains(ingredient.name!) {
                        let index = groceries.firstIndex(of: ingredient.name!)
                        amounts[index!] += ingredient.amount as! Int
                    }else{
                        groceries.append(ingredient.name!)
                        amounts.append(ingredient.amount as! Int)
                    }
            })
        })
        
        if groceries.count > 0 {
            for index in 0...groceries.count - 1 {
                finalList.append(String(groceries[index] + " " + String(amounts[index]) + "gr"))
            }
        }
        
        
        return finalList
     }
}

//
//  ShoppingList.swift
//  IOSExamenProject
//
//  Created by Kaan Calli on 07/12/2020.
//

import Foundation

class ShoppingList {
    let id: Int
    var name: String
    var recipes: [Recipe]
    
    init(id:Int,name:String,recipes:[Recipe]) {
        self.id=id
        self.name=name
        self.recipes=recipes
    }
}

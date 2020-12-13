//
//  ShoppingList+CoreDataProperties.swift
//  IOSExamenProject
//
//  Created by Kaan Calli on 13/12/2020.
//
//

import Foundation
import CoreData


extension ShoppingList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingList> {
        return NSFetchRequest<ShoppingList>(entityName: "ShoppingList")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var recipes: Recipe?

}

extension ShoppingList : Identifiable {

}

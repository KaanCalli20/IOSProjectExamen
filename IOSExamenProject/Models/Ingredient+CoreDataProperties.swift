//
//  Ingredient+CoreDataProperties.swift
//  IOSExamenProject
//
//  Created by Kaan Calli on 09/12/2020.
//
//

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var amount: NSNumber?

}

extension Ingredient : Identifiable {

}

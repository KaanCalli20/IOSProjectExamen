//
//  Ingredient+CoreDataClass.swift
//  IOSExamenProject
//
//  Created by Kaan Calli on 13/12/2020.
//
//

import Foundation
import CoreData

@objc(Ingredient)
public class Ingredient: NSManagedObject {

    
       func toString() -> String {
           var output = ""
           if let v = self.name {
               output = "\(v)"
           }
           if let v = self.amount {
               output = output + "  \(v)gr"
           }
           
           return output
        }
}

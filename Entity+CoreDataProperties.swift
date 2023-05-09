//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by KindSoft on 2023/05/09.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var name: String?

}

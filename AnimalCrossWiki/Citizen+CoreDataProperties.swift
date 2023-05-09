//
//  Citizen+CoreDataProperties.swift
//  
//
//  Created by KindSoft on 2023/05/08.
//
//

import Foundation
import CoreData


extension Citizen {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Citizen> {
        return NSFetchRequest<Citizen>(entityName: "Citizen")
    }

    @NSManaged public var name: String?
    @NSManaged public var image_url: String?
    @NSManaged public var gender: String?
    @NSManaged public var species: String?
    @NSManaged public var birthday_month: String?
    @NSManaged public var birthday_day: String?

}

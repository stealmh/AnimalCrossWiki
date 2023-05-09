//
//  CoreDataManager.swift
//  AnimalCrossWiki
//
//  Created by KindSoft on 2023/05/08.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "Citizen"
    
    func insertContent(content: AnimalModel) -> Bool {
        print(#function)
        let entity = NSEntityDescription.entity(forEntityName: "Citizen", in: self.context!)
        
        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: self.context)
            
            managedObject.setValue(content.name, forKey: "name")
            managedObject.setValue(content.birthday_day, forKey: "birthday_day")
            managedObject.setValue(content.birthday_month, forKey: "birthday_month")
            managedObject.setValue(content.gender, forKey: "gender")
            managedObject.setValue(content.image_url, forKey: "image_url")
            managedObject.setValue(content.species, forKey: "species")
            
            do {
                try self.context!.save()
                return true
            } catch {
                print(error.localizedDescription)
                return false
            }
        } else {
            return false
        }
    }
    
    func fetch() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Citizen")
        
        let result = try! context.fetch(fetchRequest)
        print(result)
        return result
    }
}

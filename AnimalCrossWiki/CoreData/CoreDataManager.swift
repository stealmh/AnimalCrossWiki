//
//  CoreDataManager.swift
//  AnimalCrossWiki
//
//  Created by KindSoft on 2023/05/08.
//

import UIKit
import RxSwift
import CoreData

class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    
    
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "Entity"
    
    func insertContent(content: AnimalModel) {
        print(#function)
        let entity = NSEntityDescription.entity(forEntityName: modelName, in: self.context!)
        
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
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetch() -> [AnimalModel] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: modelName)
        let result = try! context.fetch(fetchRequest)
        var dataToString: [AnimalModel] = []

        for data in result {
            let name = data.value(forKey: "name") as! String
            let day = data.value(forKey: "birthday_day") as! String
            let month = data.value(forKey: "birthday_month") as! String
            let gender = data.value(forKey: "gender") as! String
            let url = data.value(forKey: "image_url") as! String
            let species = data.value(forKey: "species") as! String
                
            dataToString.append(AnimalModel(name: name,
                                            image_url: url,
                                            gender: gender,
                                            species: species,
                                            birthday_month: month,
                                            birthday_day: day))
//            print(name)
        }
        
       return dataToString
    }
    
    func fetch(animalName: String) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: modelName)
        
        let result = try! context.fetch(fetchRequest)
        for data in result {
            let name = data.value(forKey: "name") as! String
            if animalName == name {
                print(name)
                return true
            }
        }
        return false
    }
    
    func delete(animalName: String) {
        print(#function)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: modelName)
        
        let result = try! context.fetch(fetchRequest)
        for data in result {
            let name = data.value(forKey: "name") as! String
            if animalName == name {
                context.delete(data)
                do {
                    try context.save()
                } catch {
                    print(error)
                }
            }
        }
    }
}

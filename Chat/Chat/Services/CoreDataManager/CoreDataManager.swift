//
//  User.swift
//  Chat
//
//  Created by Salim Maalouf on 8/12/20.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    static let shared = CoreDataManager()
    private override init() { // To prevent create new instances from outside
        
    }
    var coreDataClass = CoreDataClass()
    
    func saveData(entityName: String, attributeKey: String, attributeValue: String) -> Bool {
        let managedContext = coreDataClass.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
        let object = NSManagedObject(entity: entity, insertInto: managedContext)
        object.setValue(attributeValue, forKey: attributeKey)
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Error saving data. \(error)\n\(error.userInfo)")
            return false
        }        
    }
    
    func getData(entityName: String) -> [NSManagedObject] {
        let managedContext = coreDataClass.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        var arrayOfEntities: [NSManagedObject] = []
        do {
            arrayOfEntities = try managedContext.fetch(fetchRequest)
            return arrayOfEntities
        } catch let error as NSError {
            print("Error fetching data\(error)")
            return arrayOfEntities
        }
    }
    
    func deleteObject(object: NSManagedObject) -> Bool {
        let managedContext = coreDataClass.persistentContainer.viewContext
        managedContext.delete(object)
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Error deleting data\(error)")
            return false
        }
    }
}

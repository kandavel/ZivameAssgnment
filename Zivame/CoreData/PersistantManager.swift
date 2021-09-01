//
//  PersistantManager.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 16/08/21.
//

import Foundation
import CoreData
import UIKit

class PersistantManager {
    
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "zivame" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "zivame", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            let options: [AnyHashable: Any] = [
                NSPersistentStoreFileProtectionKey: FileProtectionType.none,  // Core data encryption key
                NSMigratePersistentStoresAutomaticallyOption: true,
                NSInferMappingModelAutomaticallyOption: true
            ]
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    struct Entity {
        static let Product = "ProductInfo"
        
    }
    
    struct Key {
        static let Quantity  = "quantity"
    }
    
    //  MARK: - COMMON HELPERS
    
    static let shareInstance = PersistantManager()
    
    func sharedAppDelegate() -> AppDelegate?{
        return (UIApplication.shared.delegate as? AppDelegate)
    }
    
    func context() -> NSManagedObjectContext?{
        return managedObjectContext
    }
    
    func save(){
        DispatchQueue.main.async {
            self.saveContext()
        }
    }
    
    func setBagCount(count : Int) {
        UserDefaults.standard.setValue(count, forKey: "bagCount")
    }
    
    func setUpdatedBagCount() {
        if let list  = getManagedObjects(Entity.Product) as? [ProductInfo]  {
            let count =  list.reduce(0, {$0 + ($1.quantity )})
            setBagCount(count: Int(count))
        }
    }
    
    func getBagCount() -> Int? {
        let bagCount  = (UserDefaults.standard.value(forKey: "bagCount") as? Int) ?? 0
        return bagCount
    }
    
    func getProductInfoList() -> [ProductInfo]? {
        if var list  = getManagedObjects(Entity.Product) as? [ProductInfo] {
            list  = list.sorted { (product1, product2) -> Bool in
                return product1.date! > product2.date!
            }
            return list
        }
        return nil
    }
    
    func getProductInfo(styleId : String) -> ProductInfo? {
        if let list  = getManagedObjects(Entity.Product,predicate:  NSPredicate(format: "id == %@",styleId)) as? [ProductInfo] {
            return list.first
        }
        return nil
    }
    
    fileprivate func addProduct(productInfo: ProductInfo,product: ProductElement,count : Int) {
        productInfo.id =  product.uniqueId
        productInfo.imageUrl =  product.imageURL
        productInfo.name =  product.name
        productInfo.price =  NSDecimalNumber(string: product.price)
        productInfo.rating =  String(product.rating ?? 0)
        productInfo.date  = Date()
        productInfo.quantity = Float(count)
        save()
    }
    
    func addItemToDB(product : ProductElement,isDecdreasequantity : Bool = false) {
        if let productInfoList  = checkProductIsAddedInDB(product: product),productInfoList.count > 0 {
           // deleteManagedObject(Entity.Product, predicate: NSPredicate(format: "id == %@",product.uniqueId.optionalValue))
            print(productInfoList.count)
            if let productInfo  = productInfoList.first {
                let count = isDecdreasequantity ? productInfo.quantity - 1 :  productInfo.quantity +  1
                if count == 0 {
                    deleteProductFromDB(styleId: product.uniqueId.optionalValue)
                }
                else {
                    productInfo.setValue(Float(count), forKey: Key.Quantity)
                }
                save()
               // addProduct(productInfo : productInfo,product : product, count: count)
            }
        }
        else {
            if let productInfo = createManagedObject(Entity.Product) as? ProductInfo {
                addProduct(productInfo : productInfo,product : product, count: 1)
            }
        }
        setUpdatedBagCount()
    }
    
    func deleteProductsInbag() {
        setBagCount(count: 0)
        deleteManagedObject(Entity.Product)
    }
    
    func deleteProductFromDB(styleId : String) {
        deleteManagedObject(Entity.Product, predicate: NSPredicate(format: "id == %@",styleId))
    }
    
    
    fileprivate func checkProductIsAddedInDB(product : ProductElement) -> [ProductInfo]? {
        if let productInfoList  =  getManagedObjects(Entity.Product,predicate: NSPredicate(format: "id == %@",product.uniqueId.optionalValue)) as? [ProductInfo] {
            return productInfoList
        }
        return nil
    }
    
    
    func createManagedObject(_ entity : String) -> NSManagedObject?{
        if let context =  context(),
           let entityDescription = NSEntityDescription.entity(forEntityName: entity,
                                                              in: context){
            return NSManagedObject(entity: entityDescription, insertInto: context)
        }
        return nil
    }
    
    func deleteManagedObject(_ entity: String,predicate : NSPredicate? = nil)  {
        if let  context = context(){
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
            fetchRequest.entity = NSEntityDescription.entity(forEntityName: entity, in: context)
            fetchRequest.includesPropertyValues = false
            fetchRequest.predicate = predicate
            do {
                if let results = try context.fetch(fetchRequest) as? [NSManagedObject] {
                    for result in results {
                        context.delete(result)
                    }
                    self.save()
                }
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
        }
    }
    
    func getManagedObjects(_ entity : String,sortDiscriptors:[NSSortDescriptor]? = nil,predicate : NSPredicate? = nil) -> [NSManagedObject]{
        var managedObjects = [NSManagedObject]()
        if let context = context(),
           let entityDescription = NSEntityDescription.entity(forEntityName: entity,
                                                              in: context){
            context.performAndWait {
                let request = NSFetchRequest<NSFetchRequestResult>()
                request.sortDescriptors = sortDiscriptors
                request.predicate = predicate
                request.entity = entityDescription
                do{
                    if let managedObjectsOptional = try context.fetch(request) as? [NSManagedObject]{
                        managedObjects = managedObjectsOptional
                    }
                }catch{
                    let _ = error as NSError
                }
            }
        }
        return managedObjects
    }
    
}

//
//  CoreDataController.swift
//  SearchTest
//
//  Created by Adam Parker on 12/05/2020.
//  Copyright © 2020 Adam Parker. All rights reserved.
//

import CoreData
import UIKit

class CoreDataController: NSObject {
    
    static let sharedInstance = CoreDataController()
    private let ENTITY_TABLE_NAME = "SavedSearches"
    private let ENTITY_KEY_NAME = "search_text"
    private let context : NSManagedObjectContext
    var coreSearchData = [SavedSearchItem]()
    
    
    override init() {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func saveItem(_ searchText: String) {
        // gethte entity we wish to add a value too.
        let entity = NSEntityDescription.insertNewObject(forEntityName: ENTITY_TABLE_NAME, into: context)
        entity.setValue(searchText, forKey: ENTITY_KEY_NAME)
        
        do{
            // Try and save, also appending the data to our custom object.
            try context.save()
            coreSearchData.append(SavedSearchItem(id: entity.objectID, searchText: searchText))
        }
        catch
        {
            // If there is some error with core data saving then we will catch the error.
            print("save data error")
        }
    }
    
    func readData() -> [SavedSearchItem]
    {
        // Remove the data from the array before we try to read from the entity table, this will stop copying of the same reference.
        self.coreSearchData.removeAll()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_TABLE_NAME)
        
        do{
            let fetchRequest = try context.fetch(request)
            for i in fetchRequest as! [NSManagedObject]
            {
                // For all values within the core data we will append the values to our custom object allowing us to return it later below.
                self.coreSearchData.append(SavedSearchItem(id: i.objectID , searchText: i.value(forKey: ENTITY_KEY_NAME) as! String))
            }
            
        }
        catch
        {
            print("read data error")
        }
        
        return coreSearchData

    }
    
}

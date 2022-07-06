//
//  CoreDataManager.swift
//  RickNMorty
//
//  Created by Fatih Gursoy on 6.07.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "RickNMorty")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private var fetchRequest: NSFetchRequest<FavoriteChar> = FavoriteChar.fetchRequest()
    
    
//MARK: Funcs
    
    var favChars: [FavoriteChar] {
        guard let items = try? mainContext.fetch(fetchRequest) else { return [] }
        return items
    }
    
    func addToFavorites(_ id: String) {
        
        if favChars.filter({ $0.id == id }).count < 1 {
            
            let favChar = FavoriteChar(context: mainContext)
            favChar.id = id
            saveContext()
        }
    }
    
    func deleteRecipe(_ id: String) {
        
        guard let favChar = favChars.filter({ $0.id == id }).first else { return }
        mainContext.delete(favChar)
        saveContext()
    }
    
    private func saveContext() {
        
        do {
            try self.mainContext.save()
        } catch {
            let error = error as NSError
            print("Unable to Delete: \(error)")
        }
        
    }

}

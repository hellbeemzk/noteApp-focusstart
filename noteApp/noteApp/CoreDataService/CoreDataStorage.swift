//
//  CoreDataStorage.swift
//  noteApp
//
//  Created by Konstantin on 02.09.2022.
//

import Foundation
import CoreData

final class CoreDataStorage {
    
    static let shared = CoreDataStorage()
    
    private init() { }
    
    // MARK: - Core Data stack
    
    private var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "noteApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    // MARK: - Core Data Add First Note Method
    
    func addFirstNote() { // Условие тестового задания
        guard UserDefaults.standard.isFirstLaunch == false else { return }
        let firstNote = Note(context: context)
        firstNote.title = "First Note Example"
        firstNote.desc = """
                         According to the technical task from CFT
                         Should be displayed when the app is first loaded!
                         """
        firstNote.id = getNotes().count - 1 as NSNumber
        self.saveContext()
        UserDefaults.standard.isFirstLaunch = true
    }
    
    
    // MARK: - Core Data Methods
    
    func getNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            return try context.fetch(fetchRequest) as! [Note]
        } catch let error {
            print("Failed to fetch data", error)
            return []
        }
    }

    func saveNote(titleNote: String, descNote: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: context) else { return }
        guard let newNote = NSManagedObject(entity: entity, insertInto: context) as? Note else { return }
        newNote.title = titleNote
        newNote.desc = descNote
        newNote.id = getNotes().count - 1 as NSNumber
        self.saveContext()
    }
    
    func deleteNote(note: Note) {
        note.deletedDate = Date()
        self.saveContext()
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

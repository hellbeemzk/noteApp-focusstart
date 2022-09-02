//
//  CoreDataStorage.swift
//  noteApp
//
//  Created by Konstantin on 02.09.2022.
//

import Foundation
//import UIKit
import CoreData

class CoreDataStorage {
    
    static let shared = CoreDataStorage()
    private init() {
//        self.addFirstNote()
    } // mb del
    
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
    
    func addFirstNote() { // заюзать для лоадвью
        
        guard UserDefaults.standard.isFirstLaunch == false else { return }
        let firstNote = Note(context: context)
        firstNote.title = "First Note Example"
        firstNote.desc = """
            According to the technical task from CFT
            Should be displayed when the app is first loaded!
            """
        firstNote.deletedDate = nil
//        firstNote.id = getNotes().count as NSNumber
        self.saveContext()
        UserDefaults.standard.isFirstLaunch = true
    }
    
    func getNotes() -> [Note] {
    let fetchRequest: NSFetchRequest<Note>
    fetchRequest = Note.fetchRequest() as! NSFetchRequest<Note>
    // Get a reference to a NSManagedObjectContext
//    let context = persistentContainer.viewContext

    // Perform the fetch request to get the objects
    // matching the predicate
        do {
            return try context.fetch(fetchRequest) // берем данные по этому запросу и передаем в массив
        } catch let error {
            print("Failed to fetch data", error)
            return []
        }
    }
    
//    func getNotes() -> [Note] {
////        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
////        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest() as! NSFetchRequest<Note>
//        do {
////            return try context.fetch(fetchRequest)
//            return try context.fetch(fetchRequest) as? [Note] ?? []
//        } catch let error {
//            print("Failed to fetch data", error)
//            return []
//        }
//    }

    
    func saveNote(titleNote: String, titleDesc: String) { // try другой метод с примера
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
//        if (note == nil) {
//        guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: context) else { return }
//        guard let newNote = NSManagedObject(entity: entity, insertInto: context) as? Note else { return }
        let newNote = Note(context: context)
//            newNote.id = note.id
            newNote.title = titleNote
            newNote.desc = titleDesc
        print("Пытаемся сохранить")
        print(getNotes().count)
            do {
                try context.save()
//                noteList.append(newNote)
//                navigationController?.popViewController(animated: true)
            } catch {
                print("context save error")
            }
//        } else {
//            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
//            do {
//                let results:NSArray = try context.fetch(request) as NSArray
//                for result in results {
//                    let note = result as! Note
//                    if(note == selectedNote) {
//                        note.title = titleTF.text
//                        note.desc = descTV.text
//                        try context.save()
//                        navigationController?.popViewController(animated: true)
//                    }
//                }
//            } catch {
//                print("Fetch Failed")
//            }
//        }
    }
    
//    func saveNote(note: Note) { // try другой метод с примера
////        let appDelegate = UIApplication.shared.delegate as! AppDelegate
////        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
////        if (note == nil) {
//        guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: context) else { return }
//        guard let newNote = NSManagedObject(entity: entity, insertInto: context) as? Note else { return }
////            newNote.id = note.id
//            newNote.title = note.title
//            newNote.desc = note.desc
//            do {
//                try context.save()
////                noteList.append(newNote)
////                navigationController?.popViewController(animated: true)
//            } catch {
//                print("context save error")
//            }
////        } else {
////            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
////            do {
////                let results:NSArray = try context.fetch(request) as NSArray
////                for result in results {
////                    let note = result as! Note
////                    if(note == selectedNote) {
////                        note.title = titleTF.text
////                        note.desc = descTV.text
////                        try context.save()
////                        navigationController?.popViewController(animated: true)
////                    }
////                }
////            } catch {
////                print("Fetch Failed")
////            }
////        }
//    }
    
    
    func deleteNote(note: Note) {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
//            let results:NSArray = try context.fetch(request) as NSArray
//            for result in results {
//                let note = result as! Note // попробовать достать из массива - найти и обнулить
//                if (note == selectedNote) {
                    note.deletedDate = Date()
                    try context.save()
//                    navigationController?.popViewController(animated: true)
//                }
//            }
        } catch {
            print("Fetch Failed")
        }
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                print("OPA IZMENILI \(getNotes().count)")
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

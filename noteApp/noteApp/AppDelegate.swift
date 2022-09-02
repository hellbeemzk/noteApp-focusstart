//
//  AppDelegate.swift
//  noteApp
//
//  Created by Konstantin on 26.09.2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        self.handleFirstLaunch()
        return true
    }
    
//    private func handleFirstLaunch() {
//        self.addFirstNote()
//    }
    
//    private func addFirstNote() {
//
//        guard UserDefaults.standard.isFirstLaunch == false else { return }
//        let application = UIApplication.shared.delegate as! AppDelegate
//        let firstNote = Note(context: context)
//        firstNote.title = "First Note Example"
//        firstNote.desc = """
//            According to the technical task from CFT
//            Should be displayed when the app is first loaded!
//            """
//        firstNote.deletedDate = nil
//        CoreDataStorage.shared.saveContext()
////        application.saveContext()
//        UserDefaults.standard.isFirstLaunch = true
//    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    // MARK: - Core Data stack
    
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "noteApp")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
    
    // MARK: - Core Data Saving support
    
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
}

//let appDelegate = UIApplication.shared.delegate as! AppDelegate
//let context = appDelegate.persistentContainer.viewContext

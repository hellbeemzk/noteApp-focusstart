//
//  NoteDetail.swift
//  noteApp
//
//  Created by Konstantin on 26.09.2021.
//

import UIKit
import CoreData

class NoteDetail: UIViewController {
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descTV: UITextView!
    
    @IBOutlet weak var boldFontButton: UIButton!
    @IBOutlet weak var italicFontButton: UIButton!
    @IBOutlet weak var redColorFontButton: UIButton!
    
    
    var selectedNote: Note? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(selectedNote != nil) {
            titleTF.text = selectedNote?.title
            descTV.text = selectedNote?.desc
        }
        
        boldFontButton.roundingButton()
        redColorFontButton.roundingButton()
        italicFontButton.roundingButton()
    }

    var isBold = false
    var isItalic = false
    var isRed = false
    
    
    @IBAction func onBoldButtonPressed(_ sender: UIButton) {
        if isBold {
            descTV.font = UIFont(name: "Helvetica Neue", size: 14)
            isBold = false
        } else {
            descTV.font = UIFont(name: "Helvetica Neue Bold", size: 14)
            isBold = true
        }
    }
    
    
    @IBAction func onItalicButtonPressed(_ sender: UIButton) {
        if isItalic == false && isBold == false {
            descTV.font = UIFont(name: "Helvetica Neue", size: 14)
            isItalic = true
            isBold = false
        } else if isItalic == true && isBold == false {
            descTV.font = UIFont(name: "Helvetica Neue Italic", size: 14)
            isItalic = false
            isBold = false
        } else if isItalic == true && isBold == true {
            descTV.font = UIFont(name: "Helvetica Neue Bold Italic", size: 14)
            isItalic = false
            isBold = true
        } else if isItalic == false && isBold == true {
            descTV.font = UIFont(name: "Helvetica Neue Bold", size: 14)
            isItalic = true
            isBold = true
        }
    }
    
    
    @IBAction func onRedColorButtonPressed(_ sender: Any) {
        if isRed {
            descTV.textColor = .black
            isRed = false
        } else {
            descTV.textColor = .red
            isRed = true
        }
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if (selectedNote == nil) {
            let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
            let newNote = Note(entity: entity!, insertInto: context)
            newNote.id = noteList.count as NSNumber
            newNote.title = titleTF.text
            newNote.desc = descTV.text
            do {
                try context.save()
                noteList.append(newNote)
                navigationController?.popViewController(animated: true)
            } catch {
                print("context save error")
            }
        } else {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let note = result as! Note
                    if(note == selectedNote) {
                        note.title = titleTF.text
                        note.desc = descTV.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            } catch {
                print("Fetch Failed")
            }
        }
    }
    
    
    @IBAction func DeleteNote(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results {
                let note = result as! Note
                if(note == selectedNote) {
                    note.deletedDate = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        } catch {
            print("Fetch Failed")
        }
    }
    
}

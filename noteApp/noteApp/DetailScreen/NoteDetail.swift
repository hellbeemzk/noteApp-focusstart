//
//  NoteDetail.swift
//  noteApp
//
//  Created by Konstantin on 26.09.2021.
//

import UIKit

final class NoteDetail: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleNote: UITextField!
    @IBOutlet weak var descriptionNote: UITextView!
    @IBOutlet weak var boldFontButton: UIButton!
    @IBOutlet weak var italicFontButton: UIButton!
    @IBOutlet weak var redColorFontButton: UIButton!
    
    var selectedNote: Note?
    var dataStorage = CoreDataStorage.shared
    
    private var isBold = false
    private var isItalic = false
    private var isRed = false
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    // MARK: - Methods
    
    private func setupView() {
        self.titleNote.text = self.selectedNote?.title
        self.descriptionNote.text = self.selectedNote?.desc
    }
    
    @IBAction func onBoldButtonPressed(_ sender: UIButton) {
        self.descriptionNote.font = isBold ? UIFont(name: "Helvetica Neue", size: 14) :
                                             UIFont(name: "Helvetica Neue Bold", size: 14)
        isBold.toggle()
    }

    @IBAction func onItalicButtonPressed(_ sender: UIButton) {
        switch (isBold, isItalic) {
        case (false, false):
            self.descriptionNote.font = UIFont(name: "Helvetica Neue", size: 14)
            isItalic.toggle()
        case (false, true):
            self.descriptionNote.font = UIFont(name: "Helvetica Neue Italic", size: 14)
            isItalic.toggle()
        case (true, true):
            self.descriptionNote.font = UIFont(name: "Helvetica Neue Bold Italic", size: 14)
            isItalic.toggle()
        case (true, false):
            self.descriptionNote.font = UIFont(name: "Helvetica Neue Bold", size: 14)
            isItalic.toggle()
        }
    }
    
    @IBAction func onRedColorButtonPressed(_ sender: Any) {
        self.descriptionNote.textColor = isRed ? .black : .red
        isRed.toggle()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if self.selectedNote == nil {
            guard let title = self.titleNote.text, title != "",
                  let desc = self.descriptionNote.text, desc != ""
            else {
                self.showAlert()
                return
            }
            self.dataStorage.saveNote(titleNote: title, descNote: desc)
            navigationController?.popViewController(animated: true)
        } else {
            let results = self.dataStorage.getNotes()
            for resultNote in results {
                if resultNote == self.selectedNote {
                    resultNote.title = self.titleNote.text
                    resultNote.desc = self.descriptionNote.text
                    navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    @IBAction func deleteNote(_ sender: Any) {
        guard let selectedNote = self.selectedNote else { return }
        self.dataStorage.deleteNote(note: selectedNote)
        navigationController?.popViewController(animated: true)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Ошибка сохранения",
                                      message: "Пустую заметку невозможно сохранить",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

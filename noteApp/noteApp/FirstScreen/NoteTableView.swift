//
//  NoteTableView.swift
//  noteApp
//
//  Created by Konstantin on 26.09.2021.
//

import UIKit

final class NoteTableView: UITableViewController {
    
    // MARK: - Properties
    
    let dataStorage = CoreDataStorage.shared
    var noteList: [Note] {
        self.dataStorage.getNotes()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        self.dataStorage.addFirstNote()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: - Methods
    
    private func getNonDeletedNotes() -> [Note] {
        var nonDeleteNoteList = [Note]()
        for note in self.noteList {
            if note.deletedDate == nil {
                nonDeleteNoteList.append(note)
            }
        }
        return nonDeleteNoteList
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getNonDeletedNotes().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noteCell = tableView.dequeueReusableCell(withIdentifier: "noteCellID", for: indexPath) as! NoteCell
        let thisNote: Note!
        thisNote = self.getNonDeletedNotes()[indexPath.row]
        noteCell.titleLabel.text = thisNote.title
        noteCell.descLabel.text = thisNote.desc
        return noteCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editNote", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editNote" {
            let indexPath = self.tableView.indexPathForSelectedRow!
            let noteDetail = segue.destination as? NoteDetail
            let selectedNote = self.getNonDeletedNotes()[indexPath.row]
            noteDetail?.selectedNote = selectedNote
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

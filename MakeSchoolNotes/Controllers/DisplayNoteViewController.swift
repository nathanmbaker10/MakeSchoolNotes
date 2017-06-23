//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
class DisplayNoteViewController: UIViewController {
    @IBOutlet weak var noteContentTextView: UITextView!
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 1
        if let note = note {
            noteTitleTextField.text = note.title
            noteContentTextView.text = note.content
            navigationBar.title = noteTitleTextField.text
        } else {
        noteTitleTextField.text = ""
        noteContentTextView.text = ""
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Save" {
            // if note exists, update title and content
            let note = self.note ?? CoreDataHelper.createNote()
            note.title = noteTitleTextField.text ?? ""
            note.content = noteContentTextView.text ?? ""
            note.modificationTime = Date() as NSDate
            CoreDataHelper.saveNote()
        }
    }
}

extension DisplayNoteViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var newTitle: String = ""
        if textField.text!.characters.count != 0 {
            if string == "" {
                let index = textField.text?.index((textField.text?.startIndex)!, offsetBy: (textField.text?.characters.count)! - 1)
                
                newTitle = textField.text!.substring(to: index!)
        //            print(textField.text!)
        //            print(string)
            } else {
                newTitle = textField.text! + string
            }
        }
        navigationBar.title! = newTitle
        return true
    }
}



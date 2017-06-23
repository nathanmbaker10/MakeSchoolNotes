//
//  CoreDataHelper.swift
//  MakeSchoolNotes
//
//  Created by Nathan Baker on 6/21/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHelper {
    static func createNote() -> Note {
    let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: managedContext) as! Note
    return note
    }
    
    static func saveNote() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    
    static func delete(notNeeded: Note) {
        managedContext.delete(notNeeded)
        saveNote()
    }
    
    static func retrieveNote() -> [Note] {
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        do {
            let results = try managedContext.fetch(fetchRequest)
            return results
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
        return []
    }
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let persistentContainer = appDelegate.persistentContainer
    static let managedContext = persistentContainer.viewContext
    
}

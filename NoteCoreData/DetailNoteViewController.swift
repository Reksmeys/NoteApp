//
//  DetailNoteViewController.swift
//  NoteCoreData
//
//  Created by Raksmey on 12/20/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import CoreData

class DetailNoteViewController: UIViewController, UITextViewDelegate{
    var titles: String?
    var desc: String?
    var status: String?
    var index: Int?
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteBodyTextView: UITextView!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var note:[Notes]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noteBodyTextView.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        
        titleTextField.text = titles
        noteBodyTextView.text = desc
        if status == "edit"{
            navigationItem.title = "Notes"
        }else{
            navigationItem.title = "New Notes"
            noteBodyTextView.text = "some description"
            noteBodyTextView.textColor = UIColor.gray
        }
       
     
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if noteBodyTextView.textColor == UIColor.gray{
            noteBodyTextView.text = ""
            noteBodyTextView.textColor = UIColor.black
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
       if status == "edit"{
            editNote()
       }else{
        print("add")
        
            addNewNote()
        
        }
    }
    
    func editNote(){
        self.note = try? context.fetch(Notes.fetchRequest())
        note![index!].desc = noteBodyTextView.text!
        note![index!].title = titleTextField.text!

        appDelegate.saveContext()
    }
    func addNewNote(){
        let noteForAdd = Notes(context: context)
        noteForAdd.title = titleTextField.text!
        noteForAdd.desc = noteBodyTextView.text!
        
        //after set delete update must save context
        appDelegate.saveContext()
    }
    

    @IBAction func actionPopAlertBarButton(_ sender: Any) {
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
   
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("takePhoto")
        })
        let chooseImageAction = UIAlertAction(title: "Choose Image", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("choose image")
        })
        let drawingAction = UIAlertAction(title: "Drawing", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("drawing")
        })
        let recordingAction = UIAlertAction(title: "Recording", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("recording")
        })
        let checkboxesAction = UIAlertAction(title: "Checkboxes", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Checkboxes")
        })
        optionMenu.addAction(cancelAction)
        optionMenu.addAction(takePhotoAction)
        optionMenu.addAction(chooseImageAction)
        optionMenu.addAction(drawingAction)
        optionMenu.addAction(recordingAction)
        optionMenu.addAction(checkboxesAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func moreBarButton(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        let deleteAction = UIAlertAction(title: "Delete", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("delete")
        })
        let makeACopyAction = UIAlertAction(title: "Make a copy", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("make a copy")
        })
        let sendAction = UIAlertAction(title: "Send", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("send")
        })
        let collaboratorsAction = UIAlertAction(title: "Collaborators", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("collaborator")
        })
        let labelAction = UIAlertAction(title: "Labels", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("label")
        })
        optionMenu.addAction(cancelAction)
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(makeACopyAction)
        optionMenu.addAction(sendAction)
        optionMenu.addAction(collaboratorsAction)
        optionMenu.addAction(labelAction)
        self.present(optionMenu, animated: true, completion: nil)

    }
}



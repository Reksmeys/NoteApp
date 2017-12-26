//
//  ViewController.swift
//  NoteCoreData
//
//  Created by Raksmey on 12/20/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    
    @IBOutlet weak var actionToolbar: UIToolbar!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var note:[Notes]?
    @IBOutlet weak var noteCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Notes"
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(_:)))
        longGesture.minimumPressDuration = 0.5
        longGesture.delaysTouchesBegan = false
        longGesture.delegate = self
        noteCollectionView.addGestureRecognizer(longGesture)
        self.note?.reverse()
        noteCollectionView.reloadData()

    }
    override func viewDidAppear(_ animated: Bool) {
        
        self.getNoteData()
        DispatchQueue.main.async {
            
            self.noteCollectionView.reloadData()
        }
    }
    
  
    @IBAction func actionToolbar(_ sender: Any) {
        let detail = storyboard?.instantiateViewController(withIdentifier: "detailStoryBoard")
        self.navigationController?.pushViewController(detail!, animated: true)

    }
    

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if note != nil {
            return note!.count
        }
        return 0
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "titleCell", for: indexPath) as! NoteCollectionViewCell
        let bcolor : UIColor = UIColor( red: 0.2, green: 0.2, blue:0.2, alpha: 0.3 )
        
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 1
        cell.backgroundColor = UIColor.white
       // print("color")
       
        cell.descriptionCell.text = "\(note![indexPath.row].desc!)"
        cell.titleCell.text = "\(note![indexPath.row].title!)"
       // cell.descriptionCell.text = arr[indexPath.row]
        cell.bounds.size = CGSize(width: (view.bounds.width / 2) , height: (view.bounds.width / 2 ) - 5)
        return cell
     
        
    }
    
    func getNoteData(){
        
        self.note = try? context.fetch(Notes.fetchRequest())
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = storyboard?.instantiateViewController(withIdentifier: "detailStoryBoard") as! DetailNoteViewController
        print(note![indexPath.row].desc!)
        print(note![indexPath.row].title!)
        
        detail.desc = note![indexPath.row].desc!
        detail.titles = note![indexPath.row].title!
        detail.status = "edit"
        detail.index = indexPath.row
        self.navigationController?.pushViewController(detail, animated: true)
    }
 
    @objc func longTap(_ sender: UIGestureRecognizer){
        print("Long tap")
        if sender.state == .ended {
            print("UIGestureRecognizerStateEnded")
            //Do Whatever You want on End of Gesture
        }
        else if sender.state == .began {
            print("UIGestureRecognizerStateBegan.")
            //Do Whatever You want on Began of Gesture
            
            let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
            {
                (alert: UIAlertAction!) -> Void in
                print("Cancelled")
            })
            let p = sender.location(in: self.noteCollectionView)
            
            if let indexPath = self.noteCollectionView.indexPathForItem(at: p){
                print("index cell \(indexPath.row)")
                let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler:
                {
                
                    (alert: UIAlertAction!) -> Void in
                    print("index \(indexPath.row)")
                    let note = self.note?[indexPath.row]
                    self.context.delete(note!)
                    self.appDelegate.saveContext()
                    self.getNoteData()
                    self.noteCollectionView.reloadData()
                    print("delete cell by \(indexPath.row)")
  
                })
                optionMenu.addAction(deleteAction)
            }
            optionMenu.addAction(cancelAction)
            
          
            self.present(optionMenu, animated: true, completion: nil)
        }
    }

    
}




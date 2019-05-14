//
//  SavedNoteController.swift
//  Sticky Notes
//
//  Created by Harrison Leath on 5/13/19.
//  Copyright © 2019 Harrison Leath. All rights reserved.
//

import UIKit
import Firebase
import DrawerView

struct Note {
    let text: String
}

class SavedNoteController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    let db = Firestore.firestore()
    
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchNotes()
    }
    
    func fetchNotes() {
        db.collection("notes").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    func setupView() {
        view.backgroundColor = .white
        
//        let text = UITextView(frame: CGRect(x: 0, y: 100, width: screenWidth, height: screenHeight))
//        text.text = "Note Collection"
//        text.textColor = .black
//        text.isEditable = false
//        view.addSubview(text)
//
        let drawer = addDrawerView(withViewController: WriteNoteController(), parentView: view)
        drawer.position = .open
    }
    
//    func fetchNotes() {
//        let ref = Database.database().reference()
//        let query = ref.child("notes").queryOrdered(byChild: "userId")
//        query.observe(.value) { (snapshot) in
//            for child in snapshot.children.allObjects as! [DataSnapshot] {
//                if let value = child.value as? NSDictionary {
//                    //                    let timestamp = value["timestamp"] as? String ?? "Timestamp not found"
//                    //                    let userId = value["userId"] as? String ?? "UserId not found"
//                    let text = value["text"] as? String ?? "Text not found"
//                    print(text)
//                    //                    Note.init(text: text)
//                    
//                    //                    self.items.removeAll()
//                    //                    self.items.append(Note.init(text: text))
//                    
//                }
//            }
//        }
//    }
    
}


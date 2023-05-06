//
//  CachViewController.swift
//  ToDoListRealm
//
//  Created by Alex Grazhdan on 06.05.2023.
//

import UIKit
import RealmSwift

class DetailedViewController: UIViewController {
    
    public var item : ToDoListItem?
    
    public var deletionHandler : (()-> Void)?
    
    @IBOutlet weak var dataText: UILabel!
    @IBOutlet weak var textItem: UILabel!
    
    private var realm = try! Realm()
    
    static let dateFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
//        dateFormatter.dateFormat
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataText.text = Self.dateFormatter.string(from: item!.data)
        textItem.text = item?.item
        
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
    }
    
                                                    
   @objc func didTapDelete(){
      guard let item = self.item else {
           return
       }
       realm.beginWrite()
       
       realm.delete(item)
       try! realm.commitWrite()
       
       deletionHandler!()
       navigationController?.popViewController(animated: true)
    }

}

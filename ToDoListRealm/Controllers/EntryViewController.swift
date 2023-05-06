//
//  EntryViewController.swift
//  ToDoListRealm
//
//  Created by Alex Grazhdan on 06.05.2023.
//

import UIKit
import RealmSwift

class EntryViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var dataPicker: UIDatePicker!
    
    private var realm = try! Realm()
    
    public var completionHandler: (()-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.becomeFirstResponder()
        textField.delegate = self
        dataPicker.setDate(Date(), animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
    }
    
  @objc func didTapSaveButton(){
      
      if let text = textField.text, !text.isEmpty {
          let date = dataPicker.date
          
          realm.beginWrite()
          
          let newitem = ToDoListItem()
          newitem.data = date
          newitem.item = text
          realm.add(newitem)
          
          try! realm.commitWrite()
          
          completionHandler!()
          navigationController?.popViewController(animated: true)
      } else {
          print("Add something")
      }
      
    }

}

extension EntryViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

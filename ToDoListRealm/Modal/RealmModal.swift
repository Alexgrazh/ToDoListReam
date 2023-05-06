//
//  RealmModal.swift
//  ToDoListRealm
//
//  Created by Alex Grazhdan on 06.05.2023.
//

import UIKit
import RealmSwift

class ToDoListItem : Object {
    @objc dynamic var item: String = ""
    @objc dynamic var data: Date = Date()
    
}

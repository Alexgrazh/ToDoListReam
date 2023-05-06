//
//  ViewController.swift
//  ToDoListRealm
//
//  Created by Alex Grazhdan on 06.05.2023.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    private var realm = try! Realm()
    
    private var data = [ToDoListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = realm.objects(ToDoListItem.self).map({ $0 })
        
        tableView.dataSource = self
        tableView.delegate = self
        
       
    }


    @IBAction func addButtonPrassad(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "entry") as? EntryViewController else{

            return
        }
        
//        let alert = UIAlertController(title: "New Item", message: "Add new tasks", preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//        let saveAction = UIAlertAction(title: "Save", style: .default)
//        alert.addAction(cancelAction)
//        alert.addAction(saveAction)
//        present(alert, animated: true)
        
        
        vc.completionHandler = {
            self.refresh()
        }
        vc.title = "New Item"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    public func refresh(){
        data = realm.objects(ToDoListItem.self).map({ $0 })
        tableView.reloadData()
      
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = data[indexPath.row]
        
        guard let vc = storyboard?.instantiateViewController(identifier: "view") as? DetailedViewController else{
            return
        }
        
        vc.item = item
        vc.deletionHandler = { [weak self] in
            self?.refresh()
            
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = item.item
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text  = data[indexPath.row].item
        return cell
    }
    
    
}

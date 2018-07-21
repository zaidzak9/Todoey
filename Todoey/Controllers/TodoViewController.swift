//
//  ViewController.swift
//  Todoey
//
//  Created by Zaid Zakir on 7/19/18.
//  Copyright © 2018 Zaid Zakir. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {
    
    var strangerThings = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let item1 = Item()
        item1.title = "Find Mike"
        strangerThings.append(item1)
        
        let item2 = Item()
        item2.title = "Buy Eggos"
        strangerThings.append(item2)
        
        let item3 = Item()
        item3.title = "Kill dermagogen"
        strangerThings.append(item3)
        
        if let itemsList = defaults.array(forKey: "ToDolist") as? [Item]{
            strangerThings = itemsList
//        }
    }
    
    //MARK - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoitemcell", for: indexPath)
        
        let itemsc = strangerThings[indexPath.row]
        cell.textLabel?.text = itemsc.title
        
        cell.accessoryType = itemsc.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strangerThings.count
    }
    
    //MARK - Table view delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        strangerThings[indexPath.row].done = !strangerThings[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func UIaddbtn(_ sender: UIBarButtonItem) {
        
        var txtfield = UITextField()
        
        let uialert = UIAlertController.init(title: "Add ToDo Item", message: nil, preferredStyle: .alert)
        
        let uiaction = UIAlertAction.init(title: "Add Action", style:.default) { (action) in
            
            let item = Item()
            item.title = txtfield.text!
            self.strangerThings.append(item)
            
            self.defaults.set(self.strangerThings, forKey: "ToDolist")
            self.tableView.reloadData()
        }
        
        uialert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Enter item"
            txtfield = alertTextfield
        }
        
        uialert.addAction(uiaction)
        
        present(uialert, animated: true, completion: nil
        )
    }
    
}


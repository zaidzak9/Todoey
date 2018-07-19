//
//  ViewController.swift
//  Todoey
//
//  Created by Zaid Zakir on 7/19/18.
//  Copyright © 2018 Zaid Zakir. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {
    
    var strangerThings = ["Find Mike","Buy eggos","Kill demergogen"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoitemcell", for: indexPath)
        
        cell.textLabel?.text = strangerThings[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strangerThings.count
    }
    
    //MARK - Table view delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        print(strangerThings[indexPath.row])
    }
    
    @IBAction func UIaddbtn(_ sender: UIBarButtonItem) {
        
        var txtfield = UITextField()
        
        let uialert = UIAlertController.init(title: "Add ToDo Item", message: nil, preferredStyle: .alert)
        
        let uiaction = UIAlertAction.init(title: "Add Action", style:.default) { (action) in
            self.strangerThings.append(txtfield.text!)
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


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
    
//    let defaults = UserDefaults.standard
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //print(dataFilePath)
        
        loaditems()
        
//        if let itemsList = defaults.array(forKey: "ToDolist") as? [Item]{
//            strangerThings = itemsList
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
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func UIaddbtn(_ sender: UIBarButtonItem) {
        
        var txtfield = UITextField()
        
        let uialert = UIAlertController.init(title: "Add ToDo Item", message: nil, preferredStyle: .alert)
        
        let uiaction = UIAlertAction.init(title: "Add Action", style:.default) { (action) in
            
            let item = Item()
            item.title = txtfield.text!
            self.strangerThings.append(item)
            
            self.saveItems()
            
        }
        
        uialert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Enter item"
            txtfield = alertTextfield
        }
        
        uialert.addAction(uiaction)
        
        present(uialert, animated: true, completion: nil
        )
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(strangerThings)
            try data.write(to: dataFilePath!)
        } catch{
            print("error")
        }
        
        //self.defaults.set(self.strangerThings, forKey: "ToDolist")
        tableView.reloadData()
    }
    
    func loaditems(){
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            
            do{
                strangerThings = try decoder.decode([Item].self, from: data)
            } catch{
                print("error")
            }
        }
    }
    
}


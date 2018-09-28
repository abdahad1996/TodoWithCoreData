//
//  ViewController.swift
//  TodoWithCoreData
//
//  Created by Arsal Jamal on 27/09/2018.
//  Copyright © 2018 abdulahad. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    // singelton
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newItem = Item()
        newItem.title = "find mike"
        itemArray.append(newItem)
        
        let newItems = Item()
        newItems.title = "find abdul"
        itemArray.append(newItems)
        
        
        let newItemss = Item()
        newItemss.title="find messi"
        itemArray.append(newItemss)

        
        
        
        
       
        
        //print(itemArray)
        //self.defaults.set(self.itemArray, forKey: "TodoArray")
        if let item = defaults.array(forKey: "TodoArray") as? [Item] {
        itemArray=item
        }
        
    }
    
    
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:
            indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath,animated: true)
      
    }
  
    @IBAction func buttonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //print(textfield.text!)
            let newItem = Item()
            newItem.title=textfield.text!
            self.itemArray.append(newItem)
            
            
            //PERSISTENT STORAGE USING USERDEFAULT
            self.defaults.set(self.itemArray, forKey: "TodoArray")
            
            
            self.tableView.reloadData()
            
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textfield=alertTextField
            
        }
        present(alert, animated: true, completion:nil)
        
    }


}

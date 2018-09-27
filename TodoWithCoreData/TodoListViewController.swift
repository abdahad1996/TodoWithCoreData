//
//  ViewController.swift
//  TodoWithCoreData
//
//  Created by Arsal Jamal on 27/09/2018.
//  Copyright © 2018 abdulahad. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["a","b","c"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.textLabel?.text=itemArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath,animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
        else
        {
    
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    
        }
    }
  
}


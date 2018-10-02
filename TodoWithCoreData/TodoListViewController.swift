//
//  ViewController.swift
//  TodoWithCoreData
//
//  Created by Arsal Jamal on 27/09/2018.
//  Copyright © 2018 abdulahad. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    var itemArray = [Item]()
    // as soon as selected category gets set the did set method works
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext    // singelton
    
    
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
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        //context.delete(itemArray[indexPath.row])
        
        
        //itemArray.remove(at: indexPath.row)
        saveItems()
        tableView.deselectRow(at: indexPath,animated: true)
      
    }
  
    @IBAction func buttonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
          
            let newItem = Item(context: self.context)
            newItem.title = textfield.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            
            
            
            self.saveItems()
            
        }
       
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textfield=alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion:nil)
        
    }
    func saveItems(){
        do  {
            try context.save()
            }
        catch{
            print("error saving context \(error)" )
            }
        self.tableView.reloadData()
    }
    func loadItems(with request:NSFetchRequest<Item> = Item.fetchRequest()//,predicate : NSPredicate? = nil){
        ){
         //let categoryPredicate = NSPredicate(format:"parentCategory.name MATCHES @%", selectedCategory!.name!)
      //  if let additionalPredicate = predicate{
         //   request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
       // }
      //  else{
       // request.predicate = categoryPredicate
       // }
        do{
       itemArray = try context.fetch(request)
    }
        catch{
        print("error fectching data from context \(error)")
            
        }
    
    tableView.reloadData()
    }
    
    
}

//querying database

extension TodoListViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
       let request : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format:"title CONTAINS[cd] %@", searchBar.text!)
        request.predicate = predicate
        let sort = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sort]
        loadItems(with : request)
 
    }
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text! == ""{
            loadItems()
            DispatchQueue.main.async {
            searchBar.resignFirstResponder()            }
           
       }
    }
    
}


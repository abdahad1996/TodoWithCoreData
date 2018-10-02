//
//  CategoryViewController.swift
//  TodoWithCoreData
//
//  Created by Arsal Jamal on 29/09/2018.
//  Copyright © 2018 abdulahad. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryarray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override  func viewDidLoad() {
        super.viewDidLoad()
        loadcategory()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath)
        let newcategory = categoryarray[indexPath.row]
        cell.textLabel?.text = newcategory.name
        
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryarray.count
    }
    
    @IBAction func buttonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title:"Add", style: .default) { (Action) in
            
            let newcategory = Category(context: self.context)
            newcategory.name = textfield.text!
            self.categoryarray.append(newcategory)
            self.savecategory()
            
        }
        alert.addTextField { (UITextField) in
            UITextField.placeholder = "create new category"
            textfield = UITextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func loadcategory(){
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do
        {
           categoryarray = try context.fetch(request)
        }
        catch{
            print("error fetching data \(error)")
        }
        tableView.reloadData()
    }
    func savecategory(){
        
        do{
           try context.save()
        }
        catch{
            print("error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoitems", sender: self)
        print(categoryarray[indexPath.row].name!)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationvc = segue.destination as! TodoListViewController
        if let indexpath = tableView.indexPathForSelectedRow{
           destinationvc.selectedCategory = categoryarray[indexpath.row]
            print(categoryarray[indexpath.row].name!)
        }
    }
    

}

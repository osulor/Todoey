//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Mubarak Akinbola on 2/3/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    
    let realm = try! Realm()
    
    //Results is the data type of the response got back from query realm
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        loadCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navigation controller doesn't exist")
        }
        
        navBar.backgroundColor = UIColor(hexString: "1D9BF6")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Category Added yet"
        
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].color ?? "1D9BF6")
        
        return cell
      
    }
    
    //MARK: - Table view delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectCategory = categories?[indexPath.row]
        }
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Category", message: " ", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add", style: .default) { (action) in

            let newCategory = Category()
            newCategory.name  = textField.text!
            newCategory.color = UIColor.randomFlat().hexValue()
            
            self.saveCategories(category: newCategory)
          //  self.loadCategories()
        }

        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add new category"
        }

        present(alert,animated: true,completion: nil)
    }
    
    //MARK: - DATA MANIPULATION
    
    func saveCategories(category: Category){
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving categories \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories(){
        //fetch data from realm
        categories = realm.objects(Category.self)

        tableView.reloadData()
    }
    
    //MARK: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath){
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do{
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error Deleting category: \(error)")
            }
        }
    }
    
}

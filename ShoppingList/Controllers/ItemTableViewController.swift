//
//  ItemTableViewController.swift
//  ShoppingList
//
//  Created by Eryk Szcześniak on 11/08/2020.
//  Copyright © 2020 Eryk Szcześniak. All rights reserved.
//

import UIKit

class ItemTableViewController: BaseTableViewController {
    
    
  
    var list: ShoppingList!
    var items: [Item] {
      get {
        return list.items
      }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Shopping list items"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItems?.append(editButtonItem)

    }

 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return items.count

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        
        
        if item.isChecked {
            
        cell.accessoryType = .checkmark
            
        } else {
            
        cell.accessoryType = .none
            
        }

        return cell
    }
    
    
    @IBAction func didSelectAdd(_ sender: UIBarButtonItem) {
      requestInput(title: "New shopping list item",
                   message: "Enter item to add to the shopping list:",
                   handler: { (itemName) in
        let itemCount = self.items.count;
        let item = Item(name: itemName)
        self.list.add(item)
        self.tableView.insertRows(at: [IndexPath(row: itemCount, section: 0)], with: .top)
      })
    }
    

    
    //enabling editing
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    //delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            list.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    //enabling moving

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    list.swapItem(fromIndexPath.row, to.row)
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
      return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      list.toggleCheckItem(atIndex: indexPath.row)
      tableView.reloadRows(at: [indexPath], with: .middle)
    }

}

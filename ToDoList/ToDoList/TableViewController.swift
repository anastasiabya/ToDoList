//
//  TableViewController.swift
//  ToDoList
//
//  Created by Timur Korop on 31.03.2020.
//  Copyright © 2020 Anastasia Korop. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UITableViewController {

    
    @IBAction func pushEditAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        tableView.reloadData()
    }
    
    @IBAction func pushAddAction(_ sender: Any) {
        let title = "Create new ToDo"
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.addTextField{(textField) in
            textField.placeholder = "ToDo name"
        }
        let alertAction1 = UIAlertAction(title: "Cancel", style: .destructive)
        {(alert) in
        }
        let alertAction2 = UIAlertAction(title: "Create", style: .cancel)
        {(alert) in
            let newItem = alertController.textFields![0].text
            addItem(nameItem: newItem!)
            self.tableView.reloadData()
        }
        
        alertController.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),NSAttributedString.Key.foregroundColor : UIColor.white]), forKey: "attributedTitle")
        
        alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.systemPink
        alertAction2.setValue(UIColor.white, forKey: "titleTextColor")
        alertAction1.setValue(UIColor.white, forKey: "titleTextColor")
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        present(alertController, animated: true, completion: nil)
        alertController.view.tintColor = UIColor.blue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.groupTableViewBackground

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ToDoItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let currentItem = ToDoItems[indexPath.row]
        cell.textLabel?.text=currentItem["Name"] as? String
        
        if (currentItem["isCompleted"] as? Bool)==true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        if tableView.isEditing {
            cell.textLabel?.alpha = 0.4
        } else {
            cell.textLabel?.alpha = 1
        }
//        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if changeState(at: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return .none
        } else {
            return .delete
        }
        
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

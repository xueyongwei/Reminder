//
//  AddTableViewController.swift
//  Reminder
//
//  Created by 薛永伟 on 2018/9/30.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit

class AddTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.tableView.backgroundColor = .white
        
        let save = UIBarButtonItem.init(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(onSaveClick))
        self.navigationItem.rightBarButtonItem = save
        
        self.tableView.tableFooterView = UIView()
        
    }

    @objc func onSaveClick(){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "noteEdit" {
            let vc = segue.destination as! EditorViewController
            vc.title = "编辑备注"
          
        }else if segue.identifier == "titleEdit" {
            let vc = segue.destination as! EditorViewController
            vc.title = "编辑事件名"
        }else{
            
        }
    }
 

}


class AddTableViewCell: UITableViewCell {
   
}

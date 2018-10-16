//
//  ReminderTableViewController.swift
//  Reminder
//
//  Created by 薛永伟 on 2018/10/16.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit

class ReminderTableViewController: UITableViewController {

    var dataSource = [Reminder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        qurryAlldata()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        NotificationCenter.default.addObserver(self, selector: #selector(qurryAlldata), name: NSNotification.Name.EX.coreDataChanged, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @objc func qurryAlldata(){
        if let dataSource = Persistent.store.qurryAllData(){
            self.dataSource = dataSource
        }
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderTableViewCell", for: indexPath) as! ReminderTableViewCell
        let reminder = self.dataSource[indexPath.row]
        cell.nameLabel.text = reminder.name
        cell.dateLael.text = reminder.fireDate?.description
        cell.noteLabel.text = reminder.note
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reminder = self.dataSource[indexPath.row]
        let editvc = self.storyboard?.instantiateViewController(withIdentifier: "EditTableViewController") as! EditTableViewController
        editvc.model = reminder
        editvc.editType = .update
        self.navigationController?.pushViewController(editvc, animated: true)
    }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

class ReminderCell:UITableViewCell{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLael: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
}

extension ReminderTableViewController{
    
    
    
}

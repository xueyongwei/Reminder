//
//  AddTableViewController.swift
//  Reminder
//
//  Created by 薛永伟 on 2018/9/30.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit

class EditTableViewController: UITableViewController {
    
    enum EditType {
        case add
        case update
    }

    
    
    
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var noteTF: UITextField!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var repeatLabel: UILabel!
    @IBOutlet weak var notiSwitch: UISwitch!
    
//    @IBOutlet weak var cleaSwitch: UISwitch!
    
    var editType = EditType.add
    
    var model:Reminder?
    
    var currentRepeatModel = RepeatModelViewController.RepeatType.once
    var fireDate:Date?
    
    lazy var footer: EditorViewController.FooterView = {
        let view = EditorViewController.FooterView()
        view.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 120)
        view.backgroundColor = .white
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        if editType == .add{
            let save = UIBarButtonItem.init(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(onSaveClick))
            self.navigationItem.rightBarButtonItem = save
        }else{
            let save = UIBarButtonItem.init(title: "Update", style: UIBarButtonItem.Style.plain, target: self, action: #selector(onUpdateClick))
            self.navigationItem.rightBarButtonItem = save
        }
        if self.editType == .update{
            footer.deleteHandel = {[weak self] in
                self?.deleteThisReminder()
            }
            self.tableView.tableFooterView = footer
            
            setUpDefalutModel()
        }else{
            self.tableView.tableFooterView = UIView()
        }
        
    }
    
    
    
    
//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if editType == .update && section == 1{
//            return 60
//        }
//        return 0.0
//    }
//
//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return footer
//    }
    
    
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
            vc.defaultText = self.noteTF.text
            vc.commitHandle = {[weak self] str in
                self?.noteTF.text = str
            }
        }else if segue.identifier == "titleEdit" {
            let vc = segue.destination as! EditorViewController
            vc.title = "编辑事件名"
            vc.defaultText = self.nameTF.text
            vc.commitHandle = {[weak self] str in
                self?.nameTF.text = str
            }
        }else if segue.identifier == "repeatModel" {
            let vc = segue.destination as! RepeatModelViewController
            vc.repeatType = self.currentRepeatModel
            vc.repeatedChodes = {[weak self] model in
                self?.currentRepeatModel = model
                self?.repeatLabel.text = model.showText()
            }
            
        }else if segue.identifier == "fireDate" {
            let vc = segue.destination as! TimeChoseViewController
            vc.chosedTimeHandle = {[weak self] date in
                self?.fireDate = date
                self?.timeLabel.text = date.reminderFormater()
            }
            
        }else{
            
        }
    }
 

}

//MARK: -  触发方法
extension EditTableViewController{
    @objc func onSaveClick(){
        safeToDB()
    }
    @objc func onUpdateClick(){
        if let reminder = model{
            guard  let name = self.nameTF.text,let date = self.fireDate else {
                EZAlertController.alert("事件名和提醒时间必填")
                return
            }
            if Persistent.store.updateReminder(reminder, name: name, note: noteTF.text, fireDate: date, repeatType: self.currentRepeatModel.rawValue, shouldNoti: self.notiSwitch.isOn, shouldCalendar: false) {
                self.navigationController?.popViewController(animated: true)
            }
            
        }
    }
    func safeToDB(){
        guard  let name = self.nameTF.text,let date = self.fireDate else {
            EZAlertController.alert("事件名和提醒时间必填")
            return
        }
        
        if Persistent.store.addNewReminder(name: name, note: self.noteTF.text ?? "", fireDate: date, repeatType: self.currentRepeatModel.rawValue, shouldNoti: self.notiSwitch.isOn, shouldCalendar: false)
        {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func setUpDefalutModel(){
        if let reminder = self.model{
            
            self.fireDate = reminder.fireDate
            
            
            self.nameTF.text = reminder.name
            self.noteTF.text = reminder.note
            
            
            self.repeatLabel.text = RepeatModelViewController.RepeatType.init(rawValue: reminder.repeatType)?.showText()
            self.timeLabel.text  = reminder.fireDate!.reminderFormater()
            
            self.notiSwitch.isOn = reminder.notify
//            self.cleaSwitch.isOn = reminder.calendar
        }
        
    }
    
    func fireDateShowText(_ reminder:Reminder) -> String {
        
        var showText = ""
        if let repeatModel = RepeatModelViewController.RepeatType.init(rawValue: reminder.repeatType) {
            showText += repeatModel.showText()
            showText += ":"
        }
        let timezone = TimeZone.current
        let formater = DateFormatter.init()
        formater.timeZone = timezone
        formater.dateFormat = "yyyy-MM-dd HH:mm"
        showText += formater.string(from: reminder.fireDate!)
        return showText
    }
    
    func deleteThisReminder(){
        
        if let reminder = self.model{
            if Persistent.store.deleteReminder(reminder) {
                self.navigationController?.popViewController(animated: true)
            }
        }else{
            EZAlertController.alert("Can't delete")
        }
        
    }
    
}
extension EditorViewController
{
    class FooterView:UIView{
        lazy var bottomBtn: UIButton = {
            let btn = UIButton.init(type: .custom)
            btn.setTitle("DELETE", for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.backgroundColor = UIColor.red
            btn.layer.cornerRadius = 50
            btn.clipsToBounds = true
            return btn
        }()
        override init(frame: CGRect) {
            super.init(frame: frame)
            customSubviews()
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            customSubviews()
        }
        typealias DeleteHandle = ()->()
        var deleteHandel:DeleteHandle?
        func customSubviews(){
            addSubview(bottomBtn)
            bottomBtn.translatesAutoresizingMaskIntoConstraints = false

            bottomBtn.addTarget(self, action: #selector(onDeleteClick), for: .touchUpInside)
            bottomBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            bottomBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            bottomBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
            bottomBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
//            bottomBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
//
//            bottomBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
//            bottomBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
//            bottomBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
            
        }
        
        @objc func onDeleteClick(){
            EZAlertController.alert("确认删除", message: "删除后无法恢复", buttons: ["删除","取消"]) { (action, index) in
                if index == 0 {
                    self.deleteHandel?()
                }
            }
        }
    }
}
class AddTableViewCell: UITableViewCell {
    
    
}

extension Date{
    func reminderFormater() -> String{
        let timezone = TimeZone.current
        let formater = DateFormatter.init()
        formater.timeZone = timezone
        formater.dateFormat = "yyyy-MM-dd HH:mm"
        return formater.string(from: self)
    }
}

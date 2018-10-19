//
//  HistoryDescViewController.swift
//  Reminder
//
//  Created by 薛永伟 on 2018/10/19.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit

class HistoryDescViewController: UIViewController {

    var history:History?
    
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var planTimeLabel: UILabel!
    @IBOutlet weak var markTimeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = history?.name
        if let note = history?.note{
            self.noteLabel.text = note
        }
        self.planTimeLabel.text = history?.fireDate?.reminderFormater()
        self.markTimeLabel.text = history?.createDate?.reminderFormater()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

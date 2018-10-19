//
//  FirstViewController.swift
//  Reminder
//
//  Created by 薛永伟 on 2018/9/30.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {

    @IBOutlet weak var actionBtn: UIButton!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var countDownLabel: CountDownLabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var nameLabe: UILabel!
    fileprivate var timeIntervalSinceNow:Double = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countDownLabel.countDownCompleteClosure = {[weak self] in
            
            self?.refreshNoti()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        resetCountDown()
        
        refreshNoti()
    }
    
    func refreshNoti() {
        customSubviews(noReminder: true)
        if let noti = ReminderNotification.center.upcomingNoti(){
            if let userInfo = noti.userInfo{
                if let name = userInfo["name"] as? String,let note = userInfo["note"] as? String,let date = userInfo["fireDate"] as? Date{
                    self.nameLabe.text = name
                    self.noteLabel.text = note
                    
                    self.timeIntervalSinceNow = Double(noti.nextComingInterval())
                    self.resetCountDown()
                    customSubviews(noReminder: false)
                }
            }
        }else{
            self.nameLabe.text = "Nothing to do"
        }
    }
    
    
    func deleteRecentNoti() {
        if let noti = ReminderNotification.center.upcomingNoti(){
            UIApplication.shared.cancelLocalNotification(noti)
        }
    }
    
    func customSubviews(noReminder:Bool){
        self.descLabel.isHidden = noReminder
        self.countDownLabel.isHidden = noReminder
        self.noteLabel.isHidden = noReminder
        self.actionBtn.isHidden = noReminder
//        let titleText = noReminder ? "New One" : "Done"
//        self.actionBtn.setTitle(titleText, for: .normal)
    }
    
    func resetCountDown(){
        countDownLabel.start()
        
        countDownLabel.maxSecond = Int(self.timeIntervalSinceNow)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FullScreenAlertViewController {
            vc.doneClickHandle = {[weak self] in
                self?.deleteRecentNoti()
                self?.refreshNoti()
            }
        }
    }
    
}


//
//  TimeChoseViewController.swift
//  Reminder
//
//  Created by 薛永伟 on 2018/9/30.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit

class TimeChoseViewController: UIViewController {

    typealias TimeChosedHandle = (_ date:Date) -> ()
    
    @IBOutlet weak var datePickerCenterYConst: NSLayoutConstraint!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var okBtn: UIButton!
    
    var chosedTimeHandle: TimeChosedHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.alpha = 0
        datePickerCenterYConst.constant = 100
        okBtn.alpha = 0
        self.okBtn.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.datePickerCenterYConst.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 1
            self.okBtn.alpha = 1
            self.okBtn.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.view.layoutIfNeeded()
        }) { (finished) in

        }
        
    }
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        let date = sender.date
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.chosedTimeHandle?(self.datePicker.date)
        
    }
    
    @IBAction func onDoneClick(_ sender: UIButton) {
        
        self.datePickerCenterYConst.constant = 300
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 0
            self.view.layoutIfNeeded()
            self.okBtn.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            self.okBtn.alpha = 0
        }) { (finished) in
            if finished{
                self.dismiss(animated: false, completion: nil)
            }
        }
        
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

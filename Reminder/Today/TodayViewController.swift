//
//  FirstViewController.swift
//  Reminder
//
//  Created by 薛永伟 on 2018/9/30.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {

    @IBOutlet weak var countDownLabel: CountDownLabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var nameLabe: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        resetCountDown()
        countDownLabel.start()
        countDownLabel.countDownCompleteClosure = {[unowned self] in
            print("finished")
        }
    }
    
    func resetCountDown(){
        countDownLabel.prefix = ""
        countDownLabel.maxSecond = 300
    }
    
    
}


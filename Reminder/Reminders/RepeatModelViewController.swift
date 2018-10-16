//
//  RepeatModelViewController.swift
//  Reminder
//
//  Created by 薛永伟 on 2018/10/12.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit

class RepeatModelViewController: UIViewController {

    enum RepeatType:Int16 {
        case once = 0
        case daily = 1
        case monthly = 2
        case annum = 3
        
        func showText() -> String {
            switch self {
            case .once:
                return "Once"
            case .daily:
                return "Daily"
            case .monthly:
                return "Monthly"
            case .annum:
                return "Annum"
            default:
                return "Once"
            }
        }
    }
    typealias ChosedRepeatHandle = (_ type:RepeatType) -> ()
    
    @IBOutlet weak var segmentCenterYConst: NSLayoutConstraint!
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var bottomConst: NSLayoutConstraint!
    
    var repeatType = RepeatType.once
    
    var repeatedChodes: ChosedRepeatHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.alpha = 0
        segmentCenterYConst.constant = 100
        bottomConst.constant = 10
        okBtn.alpha = 0
        self.okBtn.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
        self.segmentedController.selectedSegmentIndex = Int(self.repeatType.rawValue)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.segmentCenterYConst.constant = 0
        bottomConst.constant = 110
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 1
            self.okBtn.alpha = 1
            self.okBtn.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.view.layoutIfNeeded()
        }) { (finished) in

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

//MARK: - 点击事件
extension RepeatModelViewController {
    
    @IBAction func SegmentedContrllerChanged(_ sender: UISegmentedControl) {
        let idx = sender.selectedSegmentIndex
        if let model = RepeatType.init(rawValue: Int16(idx)){
            self.repeatType = model
        }
        
    }
    
    @IBAction func onDoneClick(_ sender: UIButton) {
        
        repeatedChodes?(self.repeatType)
        
        self.segmentCenterYConst.constant = 100
        bottomConst.constant = 10
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
    
    
}

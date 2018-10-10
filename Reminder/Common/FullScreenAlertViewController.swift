//
//  FullScreenAlertViewController.swift
//  Reminder
//
//  Created by 薛永伟 on 2018/9/30.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit

class FullScreenAlertViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.alpha = 0
        self.titleLabel.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
        
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 1
            self.titleLabel.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
    
    @IBAction func onDoneClick(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 0
        }) { (finished) in
            self.dismiss(animated: false, completion: nil)
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

//
//  EditorViewController.swift
//  Reminder
//
//  Created by 薛永伟 on 2018/9/30.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let save = UIBarButtonItem.init(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(onSaveClick))
        self.navigationItem.rightBarButtonItem = save
        
        // Do any additional setup after loading the view.
    }
    
    @objc func onSaveClick(){
        self.navigationController?.popViewController(animated: true)
        
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

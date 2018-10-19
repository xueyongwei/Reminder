//
//  EditorViewController.swift
//  Reminder
//
//  Created by 薛永伟 on 2018/9/30.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit
protocol EditorViewControllerProtocol:NSObjectProtocol {
    func editorViewControllerShouldEndEdit(_ str:String?) -> Bool
}
class EditorViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var leadingConst: NSLayoutConstraint!
    @IBOutlet weak var heightConst: NSLayoutConstraint!
    
    @IBOutlet weak var trallingConst: NSLayoutConstraint!
    
    var defaultText:String? = ""
    
    weak var delegate:EditorViewControllerProtocol?
    
    typealias EditComitHandle = (String) -> ()
    
    var commitHandle: EditComitHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.alpha = 0.5
        self.leadingConst.constant = 30
        self.trallingConst.constant = 30
        self.heightConst.constant = 44
        let save = UIBarButtonItem.init(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(onSaveClick))
        self.navigationItem.rightBarButtonItem = save
        self.textField.text = defaultText
        // Do any additional setup after loading the view.
        
    }
    fileprivate func animateShow(){
        self.leadingConst.constant = 20
        self.heightConst.constant = 50
        self.trallingConst.constant = 20
        UIView.animate(withDuration: 0.2, animations: {
            self.textField.alpha = 1
            self.view.layoutIfNeeded()
        }) { (finished) in
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.textField.becomeFirstResponder()
//        animateShow()
    }
    
    @objc func onSaveClick(){
        
        self.commitHandle?(self.textField.text ?? "")
        self.navigationController?.popViewController(animated: true)
//        if self.delegate?.editorViewControllerShouldEndEdit(self.textField.text) ?? false {
        
//        }
        
        
        
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

//
//  CountDownLabel.swift
//  CountDownLabel
//
//  Created by Charlin on 16/5/30.
//  Copyright © 2016年 Charlin. All rights reserved.
//

import UIKit

class CountDownLabel: UILabel {
    
    @IBInspectable var prefix: String = ""

    /** 秒数 */
    @IBInspectable var maxSecond: Int = 0 {didSet{maxSecond_private = maxSecond}}
    var maxSecond_private: Int = 0
    
    var timer: Timer!

    override init(frame: CGRect) {super.init(frame: frame); viewprepare()}
    
    required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder); viewprepare()}
    
    func viewprepare(){
        text = prefix + "00:00"
    }
    
    
    var countDownCompleteClosure:(()->Void)?
    
    deinit {print("deinit")}
}

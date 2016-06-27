//
//  ButtonSimpleCalc.swift
//  SimpleCalc
//
//  Created by EnzoF on 26.06.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//
import Foundation
import UIKit

class ButtonSimpleCalc:UIButton{
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.designInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func designInit(){
        self.backgroundColor = UIColor.init(red: 0.5, green: 0.0, blue: 0.7, alpha: 0.0)
        self.setTitleColor(UIColor.blackColor(), forState: .Normal)
        //Доразобраться с layer
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 1.5
        self.layer.cornerRadius = 45.0
    }
}
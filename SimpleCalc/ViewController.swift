//
//  ViewController.swift
//  SimpleCalc
//
//  Created by EnzoF on 07.06.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITextFieldDelegate{
    //All Button By Calculator
    //tag 0...19
    var buttonCancel : UIButton =  ButtonSimpleCalc()  //Cancel
    var button7 : UIButton = ButtonSimpleCalc()           //7
    var button4 : UIButton = ButtonSimpleCalc()            //4
    var button1 : UIButton = ButtonSimpleCalc()            //1
    var buttonZero : UIButton = ButtonSimpleCalc()         //0
    var buttonPlusOrMinus : UIButton = ButtonSimpleCalc()  //+/-
    var button8 : UIButton = ButtonSimpleCalc()            //8
    var button5 : UIButton = ButtonSimpleCalc()            //5
    var button2 : UIButton = ButtonSimpleCalc()            //2
    var buttonDoubleZero : UIButton = ButtonSimpleCalc()   //00
    var buttonPerCent : UIButton = ButtonSimpleCalc()      //%
    var button9 : UIButton = ButtonSimpleCalc()            //9
    var button6 : UIButton = ButtonSimpleCalc()            //6
    var button3 : UIButton = ButtonSimpleCalc()            //3
    var buttonPlus : UIButton = ButtonSimpleCalc()         //+
    var buttonMinus : UIButton = ButtonSimpleCalc()        //-
    var buttonDiv : UIButton = ButtonSimpleCalc()          //Division
    var buttonTripleZero : UIButton = ButtonSimpleCalc()   //000
    var buttonMulti :   UIButton = ButtonSimpleCalc()      //Multiplication
    var buttonEqually : UIButton = ButtonSimpleCalc()      //=
    
    var rowCalculation : UITextField = UITextField()
    
    var viewCalc : UIView = UIView()
    
    
    var operatorIsEmpty : Bool = Bool.init()
    var isCurrentOperator : Bool = Bool.init()
    var isZeroInRowCalculation : Bool = false
   
    var operandStack = Array <Double>()
    
    var displayValue : Double{
    
        get{
            return (self.rowCalculation.text! as NSString).doubleValue
        }
        set{
            self.rowCalculation.text = "\(newValue)"
        }
    }
    
    
    override func loadView() {
        super.loadView()
        isZeroInRowCalculation = true
        
        let arrayButton : Array = Array.init(arrayLiteral: self.buttonCancel,self.button7,self.button4,self.button1,self.buttonZero,self.buttonPlusOrMinus,self.button8,self.button5,self.button2,self.buttonDoubleZero,self.buttonPerCent,self.button9,self.button6,self.button3,self.buttonPlus,self.buttonMinus,self.buttonDiv,self.buttonTripleZero,self.buttonMulti,self.buttonEqually)
        
        let arrayTitleButton : Array = Array.init(arrayLiteral:"C","7","4","1","0","+/-","8","5","2","00","%","9","6","3","000","+","-","÷","×","↩︎")
        
        for (index, value) in arrayButton.enumerate() {
            value.tag = index
        }
        self.geometryForAllButton(arrayButton)
        self.propertyForAllButtons(arrayButton, Array1: arrayTitleButton)

        
        self.view.addSubview(self.rowCalculation)
        rowCalculation.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraintLeft = self.horyzontalConstraintLeft(rowCalculation, toItem: self.view, multiplier: 1.0)

        let horizontalConstraintRight = self.horizontalConstraintRight(rowCalculation, toItem: view, multiplier: 1.0)

        let verticalConstraintTop = self.verticalConstrainTop(rowCalculation, toItem: view, multiplier: 1.0 ,constant: 50.0)

        let widthConstraint = self.constraintWidth(rowCalculation, toItem: view, multiplier: 1.0)

        let heightConstraint = NSLayoutConstraint(item: rowCalculation, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 65.0)
        
        view.addConstraints([verticalConstraintTop,horizontalConstraintLeft,horizontalConstraintRight,widthConstraint,heightConstraint])

        self.rowCalculation.backgroundColor = UIColor.init(red: 0.0, green: 0.5, blue: 0.0, alpha: 0.0)
            //.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        self.rowCalculation.placeholder = "Введите число"
        self.rowCalculation.textAlignment = .Right
        

        self.rowCalculation.font = UIFont.systemFontOfSize(60.0)
        self.rowCalculation.text = "0"
        self.rowCalculation.enabled = false

        
        

        let frame = CGRect.init(x: 0.0, y: 110.0, width: self.view.frame.width, height: self.view.frame.height - 110.0)
        self.viewCalc.frame = frame
        self.viewCalc.backgroundColor = UIColor.init(red: 0.0, green: 0.5, blue: 0.0, alpha: 0.0)
        
        self.viewCalc.autoresizingMask = [.FlexibleLeftMargin,.FlexibleWidth,.FlexibleRightMargin,.FlexibleHeight]

        self.view.addSubview(self.viewCalc)

        
    }
    
    func geometryForAllButton(Array:[UIButton]) -> Void{
        //Разделительные линии между кнопками
        for (index,value) in Array.enumerate() {
            switch value.tag {
            case 0:
                self.viewCalc.addSubview(value)
                let verticalConstraintTop = self.verticalConstrainTop(value, toItem: self.viewCalc, multiplier: 1.0)
    
                let horyzontalConstraintLeft = self.horyzontalConstraintLeft(value, toItem: self.viewCalc, multiplier: 1.0)
                
                let constraintWidth = self.constraintWidth(value, toItem: self.viewCalc, multiplier: 0.25)
                
                let constraintHeight = self.constraintHeight(value, toItem: self.viewCalc, multiplier: 0.2)
            
               viewCalc.addConstraints([verticalConstraintTop,horyzontalConstraintLeft,constraintWidth,constraintHeight])
                
            case 1,2,3,4:
                let previousValue = Array[index - 1]
                self.viewCalc.addSubview(value)
                
                let verticalConstraintTop = NSLayoutConstraint(item: value, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: previousValue, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0.0)
                
                
                let horyzontalConstraintLeft = self.horyzontalConstraintLeft(value, toItem: previousValue, multiplier: 1.0)

                let constraintWidth = self.constraintWidth(value, toItem: self.viewCalc, multiplier: 0.25)
                
               let constraintHeight  = self.constraintHeight(value, toItem: self.viewCalc, multiplier: 0.2)
                

                viewCalc.addConstraints([verticalConstraintTop,horyzontalConstraintLeft,constraintWidth,constraintHeight])
                
                
            case 5,6,7,8,9,10,11,12,13,14,15,16,17,18,19:
                   let  previousValue = Array[index - 5]
                self.viewCalc.addSubview(value)
                

                let verticalConstraintTop = self.verticalConstrainTop(value,toItem: previousValue, multiplier: 1.0)
    
                let horyzontalConstraintLeft = NSLayoutConstraint(item: value, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: previousValue, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0.0)

                   let constraintWidth = self.constraintWidth(value, toItem: previousValue, multiplier: 1.0)
                   
                   let constraintHeight  = self.constraintHeight(value, toItem: previousValue, multiplier: 1.0)


                viewCalc.addConstraints([verticalConstraintTop,horyzontalConstraintLeft,constraintWidth,constraintHeight])

            default:
                NSLog("Error in geometryForAllButton() \(index)")
            }

            value.translatesAutoresizingMaskIntoConstraints = false
            
        }
    }
    
    
    func propertyForAllButtons(Array:[UIButton],Array1:[String])->Void{
        for (index,value) in Array.enumerate() {
            value.setAttributedTitle(NSAttributedString(string: "\(Array1[index])", attributes: [NSFontAttributeName:UIFont.systemFontOfSize(50)]), forState: .Normal)

            value.addTarget(self, action: #selector(ViewController.actionPressButton(_:)), forControlEvents: .TouchDown)
            
            value.addTarget(self, action: #selector(ViewController.actionUPInsideButton(_:)), forControlEvents: .TouchUpInside)
            
            value.addTarget(self, action: #selector(ViewController.actionTouchUpOutside(_:)), forControlEvents: .TouchUpOutside)
            
        }
    }

    
//MARK: -AutoLayout-
    func verticalConstrainTop(item:UIView,toItem:UIView,multiplier:CGFloat,constant:CGFloat = 0.0)->NSLayoutConstraint{
        return NSLayoutConstraint(item: item, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: toItem, attribute: NSLayoutAttribute.Top, multiplier: multiplier, constant: constant)
    }
    
    func horyzontalConstraintLeft(item:UIView,toItem:UIView,multiplier:CGFloat,constant:CGFloat = 0.0)->NSLayoutConstraint{
        return NSLayoutConstraint(item: item, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: toItem, attribute: NSLayoutAttribute.Left, multiplier: multiplier, constant: constant)
    }
    
    func horizontalConstraintRight(item:UIView,toItem:UIView,multiplier:CGFloat,constant:CGFloat = 0.0)->NSLayoutConstraint{
        return NSLayoutConstraint(item: item, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: toItem, attribute: NSLayoutAttribute.Right, multiplier: multiplier, constant: constant)
    }
    
    func constraintWidth(item:UIView,toItem:UIView,multiplier:CGFloat,constant:CGFloat = 0.0)->NSLayoutConstraint{
        return NSLayoutConstraint(item: item, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: toItem, attribute: NSLayoutAttribute.Width, multiplier: multiplier, constant: constant)
    }
    
    func constraintHeight(item:UIView,toItem:UIView,multiplier:CGFloat,constant:CGFloat = 0.0)->NSLayoutConstraint{
        return NSLayoutConstraint(item: item, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem:toItem, attribute: NSLayoutAttribute.Height, multiplier: multiplier, constant: constant)
    }
    


//MARK: - Action
    
    func actionPressButton(sender:UIButton) -> Void {
        sender.backgroundColor = UIColor.init(red: 0.0, green: 0.2, blue: 0.0, alpha: 0.7)
        let text = (sender.titleLabel?.text)!
        switch text {
            case "0","00","000","1","2","3","4","5","6","7","8","9":
                inputSymbol(text)
                
            case "÷","×","+","+/-","%","C","-":
                operate(text)
                
            case "↩︎":
                enter()
                
            default:
                if ((sender.titleLabel?.text) != nil) {
                    NSLog("Error in button \(sender.titleLabel?.text)")
                }
                NSLog("Error in button")
                return
        }
    }
    
    func actionUPInsideButton(sender:UIButton) -> Void {
        sender.backgroundColor = UIColor.clearColor()
    }

    func actionTouchUpOutside(sender:UIButton) -> Void {
        sender.backgroundColor = UIColor.clearColor()
    
    }
    

    
//MARK: -Metods-
    func enter()->Void{
        self.isZeroInRowCalculation = true
        self.operandStack.append(self.displayValue)
        
    }
    func inputSymbol(symbol:String)->Void{
        switch symbol {
        case "1","2","3","4","5","6","7","8","9":
            if self.isZeroInRowCalculation{
                self.rowCalculation.text = symbol
                self.isZeroInRowCalculation = false
            }
            else{
                self.rowCalculation.text = self.rowCalculation.text! + symbol
            
            }
        case "0","00","000":
            if !self.isZeroInRowCalculation{
                self.rowCalculation.text = self.rowCalculation.text! + symbol
                self.isZeroInRowCalculation = false
            }
            
        default:
            NSLog("Error in inputSymbol \(symbol)")
            let alert = UIAlertController.init(title: "Внимание", message:"Данная кнопка на стадии доработки", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alert.addAction(defaultAction)
            
            presentViewController(alert, animated: true, completion: nil)
        }
    
    }
    
    func operate(currentOperator:String) -> Void {
        if !isZeroInRowCalculation{
            enter()
        }
        switch currentOperator {
        case "×": performOperation({$0*$1})
        case "÷": performOperation(
            {
            if ($0 == 0.0 || $1 == 0.0){
                return 0.0
                }
                return $1 / $0
            })
        case "-": performOperation({$1 - $0})
        case "+": performOperation({$0+$1})
        case "%": performOperation({
                                    if ($0 == 0.0 || $1 == 0.0){
                                        return 0.0
                                    }
                                    return $0*$1/100
                                  })
        case "+/-":
            if self.displayValue != 0{
                
                if self.rowCalculation.text!.characters.first == "-"{
                   self.rowCalculation.text!.removeAtIndex(self.rowCalculation.text!.startIndex)
                }
                else{
                        self.rowCalculation.text = "-" + self.rowCalculation.text!
                }
            }
        case "C":
            rowCalculation.text = "0"
            isZeroInRowCalculation = true
            operandStack.removeAll()
        default:
            NSLog("Error in operation \(currentOperator)")
        }
    }
    func performOperation(operation: (Double,Double)->Double){
        if operandStack.count >= 2{
            displayValue = operation (operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
}


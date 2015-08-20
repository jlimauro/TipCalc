//
//  ViewController.swift
//  Tip Calc
//
//  Created by Jeffrey Limauro on 8/16/15.
//  Copyright (c) 2015 LimauroDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var billAmount: UITextField!
    
    @IBOutlet weak var tipPercent: UITextField!
    
    @IBOutlet weak var tipStepper: UIStepper!
    
    @IBOutlet weak var tipAmount: UILabel!
    
    @IBOutlet weak var totalAmount: UILabel!
    
    @IBAction func tapAction(sender: AnyObject) {
        //This tapping of view will hid num pad
        billAmount.resignFirstResponder()
    }
    var currentValue : Double = 0.0
    var subTotal : Double = 0.0
    var calcTip : Double = 0.0
    var billAmtStr : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipStepper.wraps = true
        tipStepper.autorepeat = true
        tipPercent.text = "\(20)"
        
        currentValue = (tipPercent.text as NSString).doubleValue
        tipStepper.value = currentValue
        
        billAmount.becomeFirstResponder()

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        billAmount.resignFirstResponder()
        return true;
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calculateTip(sender: UITextField) {
        
        if (billAmount.text != nil && tipPercent.text != nil)
        {
            displayResult()
        }
    }
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
        
       
        tipPercent.text = Int(sender.value).description
        
        currentValue = (tipPercent.text as NSString).doubleValue
        
        if (billAmount.text != nil && tipPercent.text != nil)
        {
            displayResult()
        }
    }
    
    func displayResult()
    {
        subTotal = (billAmount.text as NSString).doubleValue

        calcTip = subTotal * (currentValue/100)
        
        tipAmount.text = String(format: "$%.2f", calcTip)
        
        totalAmount.text = String(format: "$%.2f", calcTip + subTotal)
    }
}


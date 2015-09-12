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
    
    @IBOutlet weak var guestNumber: UITextField!
    
    @IBOutlet weak var guestAmount: UILabel!
    
    @IBAction func tapAction(sender: AnyObject) {
        //This tapping of view will hid num pad
        billAmount.resignFirstResponder()
        guestNumber.resignFirstResponder()
    }
    
    var currentValue : Double = 0.0
    var subTotal : Double = 0.0
    var calcTip : Double = 0.0
    var guestNum : Int = 1
    var guestAmt : Double = 0.0
    var billAmtStr : String = ""
    var totalAmt : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guestNumber.text = "1"
        tipStepper.wraps = true
        tipStepper.autorepeat = true
        tipPercent.text = "\(20)"
        
        currentValue = (tipPercent.text as NSString).doubleValue
        tipStepper.value = currentValue
        
        billAmount.becomeFirstResponder()

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        billAmount.resignFirstResponder()
        guestNumber.resignFirstResponder()
        return true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CheckGuestCount(sender: UITextField) {
        
        if (guestNumber.text != nil && guestNumber.text != "" && (guestNumber.text as NSString).integerValue != 0)
        {
            guestNum = (guestNumber.text as NSString).integerValue
        }
        else
        {
            guestNumber.text = "1"
            guestNum = 1
        }
        
        displayResult()
    }
    
    @IBAction func calculateTip(sender: UITextField) {
        if (billAmount.text != nil && tipPercent.text != nil)
        {
            if (billAmount.text.hasPrefix("$"))
            {
                subTotal = (billAmount.text.componentsSeparatedByString("$")[1] as NSString).doubleValue
            }
            else
            {
                subTotal = (billAmount.text as NSString).doubleValue
            }
            
            subTotal = Double(round(100*subTotal)/100)
            
            let formatSubTotal = String(format: "%0.2f", subTotal)
            
            billAmount.text = "$\(formatSubTotal)"
            
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
        calcTip = subTotal * (currentValue/100)
        
        totalAmt = calcTip + subTotal
        
        guestAmt = totalAmt / Double(guestNum)
        
        tipAmount.text = String(format: "$%.2f", calcTip)
        
        guestAmount.text = String(format: "$%.2f", guestAmt)
        
        totalAmount.text = String(format: "$%.2f", totalAmt)
    }
}


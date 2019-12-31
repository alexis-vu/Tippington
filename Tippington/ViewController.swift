//
//  ViewController.swift
//  Tippington
//
//  Created by Alexis Lauren Vu on 12/18/19.
//  Copyright © 2019 Alexis Lauren Vu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // main view
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var twoSplitLabel: UILabel!
    @IBOutlet weak var threeSplitLabel: UILabel!
    @IBOutlet weak var fourSplitLabel: UILabel!
    @IBOutlet weak var customSplitLabel: UILabel!
    @IBOutlet weak var customSplitButton: UIButton!
    
    
    // custom tip view
    @IBOutlet weak var customTipView: UIView!
    @IBOutlet weak var customTipField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // custom split bill view
    @IBOutlet weak var customSplitView: UIView!
    @IBOutlet weak var customSplitField: UITextField!
    @IBOutlet weak var cancelButton2: UIButton!
    @IBOutlet weak var doneButton2: UIButton!
    
    // global vars
    var tipPercentage = Double(0)
    var numSplit = Int(0)
    var customSplit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // customize segmented control font and font color
        let customFont = UIFont(name: "redensek", size: 23)
        let normalTextAttributes: [NSAttributedString.Key : AnyObject] = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: customFont!
        ]
        tipControl.setTitleTextAttributes(normalTextAttributes, for: UIControl.State.normal)
        
        // ensure custom split amount fits in button view
        customSplitButton.titleLabel?.numberOfLines = 1
        customSplitButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    // SCREEN TAP LOGIC
    @IBAction func onTap(_ sender: Any) {
        // dismiss keyboard
        view.endEditing(true)
    }
    
    // CUSTOM TIP CANCEL BUTTON LOGIC
    @IBAction func onCancel(_ sender: Any) {
        // hide view and deselect all segments
        customTipView.isHidden = true
        tipControl.selectedSegmentIndex = UISegmentedControl.noSegment
        
        // reset text field to previous value
        customTipField.text = "\(Int(tipPercentage * 100))"
    }
    
    // CUSTOM TIP DONE BUTTON LOGIC
    
    @IBAction func onDone(_ sender: Any) {
        // hide view and deselect all segments
        customTipView.isHidden = true
        tipControl.selectedSegmentIndex = UISegmentedControl.noSegment
        
        // change tip amount and recalculate total
        tipPercentage = Double(customTipField.text!) ?? 0
        tipControl.setTitle("\(Int(tipPercentage))%", forSegmentAt: 3)
        tipPercentage /= 100
        calculateTip(self)
    }
    
    // CUSTOM SPLIT BUTTON LOGIC
    @IBAction func onTapSplit(_ sender: Any) {
        customSplitView.isHidden = false
        customSplitButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
    }
    
    // CUSTOM SPLIT CANCEL BUTTON LOGIC
    @IBAction func onCancelSplit(_ sender: Any) {
        // hide view
        customSplitView.isHidden = true
        view.endEditing(true)
    }
    
    // CUSTOM SPLIT DONE BUTTON LOGIC
    @IBAction func onDoneSplit(_ sender: Any) {
        // hide view and keyboard
        customSplitView.isHidden = true
        view.endEditing(true)
        
        // update split amount
        numSplit = Int(customSplitField.text!) ?? 0
        
        // flag custom tip, recalculate and reset labels
        customSplit = true
        calculateTip(self)
        customSplit = false
    }
    
    
    // TIP CALCULATOR LOGIC
    @IBAction func calculateTip(_ sender: Any) {
        // get bill amount
        let bill = Double(billField.text!) ?? 0
        
        // set tip amount
        switch tipControl.selectedSegmentIndex {
        case 0:
            tipPercentage = 0.15
            break
        case 1:
            tipPercentage = 0.18
            break
        case 2:
            tipPercentage = 0.20
            break
        case 3:
            // show custom tip view and close other decimal pad
            view.endEditing(true)
            customTipView.isHidden = false
            // segues into logic based on cancel or done button chosen
            break
        default:
            break
        }
        
        // calculate tip and total amount
        let tip = bill * tipPercentage
        let total = bill + tip
        
        // update tip and total labels
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        // update split tab labels
        twoSplitLabel.text = String(format: "$%.2f", (total / 2))
        threeSplitLabel.text = String(format: "$%.2f", (total / 3))
        fourSplitLabel.text = String(format: "$%.2f", (total / 4))
        customSplitLabel.text = String(format: "$%.2f", total / Double(numSplit))
        
        if (customSplit)
        {
            customSplitButton.setImage(nil, for: .normal)
            customSplitButton.setTitle("\(numSplit)", for: .normal)
            customSplitButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        }
    }
}


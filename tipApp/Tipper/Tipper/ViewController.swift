//
//  ViewController.swift
//  Tipper
//
//  Created by jason on 9/14/16.
//  Copyright © 2016 jasonify. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipSelector: UISegmentedControl!
    @IBOutlet weak var dollarLabel: UILabel!
    
    @IBOutlet weak var billLine: UIView!
    
    @IBOutlet weak var tipDescLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let currencyFormatter = currencyStringFromNumber()

        
        let sign  = "\(currencyFormatter.currencySymbol)"
        dollarLabel.text = sign
        
        
        tipLabel.text = currencyFormatter.stringFromNumber(0.00)
        totalLabel.text = currencyFormatter.stringFromNumber(0.00)
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.18, green:0.99, blue:0.69, alpha:1.0)

        
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.07, green:0.54, blue:0.32, alpha:1.0)

        
       
        // Do any additional setup after loading the view, typically from a nib.
        let defaults = NSUserDefaults.standardUserDefaults()
        // Because integerForKey gives zero if not set
        // which I guess should be fine...
        if let tipPercentIndex = defaults.objectForKey("tipPercentDefault") {
            tipSelector.selectedSegmentIndex = defaults.integerForKey("tipPercentDefault")
            print(tipPercentIndex)
        } else {
            print("NIL!")
            
        }
        
        billField.keyboardType = UIKeyboardType.NumbersAndPunctuation;
        
        billField.becomeFirstResponder()

    }
    override func viewWillAppear(animated: Bool) {
        billLabel.center = CGPointMake(billLabel.center.x, billLabel.center.y-40)
        
        tipDescLabel.center = CGPointMake(tipDescLabel.center.x, tipDescLabel.center.y + 40)
        tipDescLabel.alpha = 0
        
        
        dollarLabel.alpha = 0
        billLabel.alpha = 0
        billLine.alpha = 0
        tipLabel.alpha = 0
    }
    override func viewDidAppear(animated: Bool) {
        
    
        UIView.animateWithDuration(0.4, delay: 0.3, options: UIViewAnimationOptions.TransitionNone , animations: {
            
            self.dollarLabel.alpha = 1
            self.billLine.alpha = 1
            self.tipLabel.alpha = 1
            
            }, completion:  { (finished: Bool) -> Void in
            
            // you can do this in a shorter, more concise way by setting the value to its opposite, NOT value
        })
        
        UIView.animateWithDuration(0.4, animations: {
            self.billLabel.alpha = 1
            self.billLabel.center = CGPointMake(self.billLabel.center.x, self.billLabel.center.y+40)
            
            self.tipDescLabel.alpha = 1
            self.tipDescLabel.center = CGPointMake(self.tipDescLabel.center.x, self.tipDescLabel.center.y - 40)
            
        })
        
        billField.becomeFirstResponder()
    }
    
    @IBAction func onTap(sender: AnyObject) {
        print("hello")
        view.endEditing(true)
    }
    
    // Borrowed from stackoverflow:
    func currencyStringFromNumber() -> NSNumberFormatter {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.currencyCode = NSLocale.currentLocale().displayNameForKey(NSLocaleCurrencySymbol, value: NSLocaleCurrencyCode)
        return formatter
    }
    
    
    @IBAction func calculateTip(sender: AnyObject) {
        
        let tipPercentages = [0.18, 0.20, 0.25]
        
        let bill = Double(billField.text!) ?? 0
        
        let tip = bill * tipPercentages[tipSelector.selectedSegmentIndex]

        let currencyFormatter = currencyStringFromNumber()
        tipLabel.text =  currencyFormatter.stringFromNumber(tip)
        
        totalLabel.text = currencyFormatter.stringFromNumber(tip+bill)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


/*
 
 Remember the bill amount across app restarts. After an extended period of time, clear the state. This is a UI trick that Apple uses with the Spotlight app. If you return there a minute later, it will show your most recent search. if you return 10 minutes later, it defaults to blank. To implement this, plug into the application lifecycle and track time using NSDate.
 
 [x] set keyboard to number / textfield?
 
 [x] Use locale specific currency and currency thousands separator.
 [ ] Add a light/dark color theme to the settings view. In viewWillAppear, update views with the correct theme colors.
 [x] Make sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.
 [x] Add animations to your UI
 
 [x] The Tip calculator has a very primitive UI. Feel free to play with colors, layout, or even modify the UI to improve it.
    [x] chang ethe top bar / nav color


 
 Animating View Properties (Optional)
 Many UIView properties can be animated, including frame, center, backgroundColor, alpha, transform, etc.
 
 In order to animate one or more views, simply create an animation block. The animation block will animate from the current value to the value that's set within the block. You can manipulate multiple views within the block. For example, in the snippet below, firstView is fading in, while secondView is fading out. This is assuming that you've created outlets for firstView and secondView.
 
 // Optionally initialize the property to a desired starting value
 self.firstView.alpha = 0
 self.secondView.alpha = 1
 UIView.animateWithDuration(0.4, animations: {
 // This causes first view to fade in and second view to fade out
 self.firstView.alpha = 1
 self.secondView.alpha = 0
 })
 
 
 
 
 */

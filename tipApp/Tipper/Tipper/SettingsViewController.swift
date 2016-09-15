//
//  SettingsViewController.swift
//  Tipper
//
//  Created by jason on 9/14/16.
//  Copyright © 2016 jasonify. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipPercentSettings: UISegmentedControl!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.18, green:0.99, blue:0.69, alpha:1.0)
        
        
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.07, green:0.54, blue:0.32, alpha:1.0)
        
        
        let defaults =  NSUserDefaults.standardUserDefaults()
        if let tipPercentIndex = defaults.objectForKey("tipPercentDefault") {
            tipPercentSettings.selectedSegmentIndex = defaults.integerForKey("tipPercentDefault")
            print(tipPercentIndex)
        } else {
            print("NIL!")
            
        }
        
        self.tipPercentSettings.alpha = 0
        tipLabel.alpha = 0
 
        
        
        // Do any additional setup after loading the view.
    }

    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.2, animations: {
            self.tipLabel.alpha = 1
        })
        UIView.animateWithDuration(0.4, animations: {
            // This causes first view to fade in and second view to fade out
            self.tipPercentSettings.alpha = 1
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func tipPercentSettingsTapped(sender: UISegmentedControl) {
        
        let defaults =  NSUserDefaults.standardUserDefaults()
        defaults.setInteger(sender.selectedSegmentIndex, forKey: "tipPercentDefault")
        defaults.synchronize()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

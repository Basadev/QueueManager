//
//  LoginVC.swift
//  QueueManager
//
//  Created by Professional on 2015-06-07.
//  Copyright (c) 2015 Ntambwa. All rights reserved.
//

import UIKit
//import Parse

var userName:String = String()

class LoginVC: UIViewController {
    
    @IBOutlet weak var userNameLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    
    @IBAction func enterQueueManager(sender: AnyObject) {
        
        let menuVC = self.storyboard!.instantiateViewControllerWithIdentifier("menu") as! MenuVC
        //self.presentViewController(menuVC, animated: true, completion: nil)
        self.navigationController!.pushViewController(menuVC, animated: true)
    }
    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        userName = userNameLabel.text;
        //println("USERNAME \(userName) ")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

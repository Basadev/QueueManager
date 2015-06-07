//
//  QueueStateVC.swift
//  QueueManager
//
//  Created by Professional on 2015-06-07.
//  Copyright (c) 2015 Ntambwa. All rights reserved.
//
import UIKit
//Create the delegate protocol
protocol QueueDelegate {
    func decrementWaitCounter(controller: QueueStateVC)-> Int
}

class QueueStateVC: UIViewController {

    var liveQueueRoot:Firebase?
    var stmQueue:Firebase?
    var serviceRef:Firebase?
    var stmQueueUsers:Firebase?
    var count: Int?
    var myQueueName: String?
    
    //delegate variable
    var delegate: QueueDelegate?
    
    @IBOutlet weak var takeNumber: UIButton!
    @IBOutlet weak var nowServingNumber: UILabel!
    @IBOutlet weak var serviceTime: UILabel!
    
    @IBOutlet weak var cancerYourNUmber: UIButton!
    // Counter View labels
    @IBOutlet weak var counterLabel: UILabel!
    
    //user info
    var name:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        takeNumber.layer.cornerRadius = 28;
        cancerYourNUmber.layer.cornerRadius = 28;
        
        //takeNumber.layer.borderWidth = 2.0;
        //cancelNumber.layer.borderWidth = 2.0;
        
        liveQueueRoot = Firebase(url: "https://livequeue.firebaseio.com/")
        stmQueue = liveQueueRoot!.childByAppendingPath("services/")
        stmQueueUsers = stmQueue!.childByAppendingPath(myQueueName)
        
        //userName = "Remo"
        setupFirebaseCallbacks()
    }
    
    @IBAction func addClient(sender: AnyObject) {
        var counter:String! = self.counterLabel.text!;
        var newUser = ["name": userName, "number": counter]
        stmQueueUsers!.childByAppendingPath(userName).setValue(newUser)
        //var users = ["Ntambwa": Ntambwa]
        //stmQueueUsers!.setValue(users)
    }
    
    @IBAction func removeClient(sender: AnyObject) {
        
        var user = stmQueueUsers!.childByAppendingPath(userName)
        user!.removeValue()
         println("NAME: \(myQueueName)")
    }
    
    func  incrementCounter(){
        var number:Int = self.counterLabel.text!.toInt()!
        number++
        self.counterLabel.text = "\(number)"
    }
    @IBAction func test(sender: AnyObject) {
        decrementCounter()
    }
    func  decrementCounter(){
        
        var number:Int = self.counterLabel.text!.toInt()!
        if number>0{
            number--
            self.counterLabel.text = "\(number)"
        }
        
    }
    
    @IBAction func cancerNumberAction(sender: AnyObject) {
        var user = stmQueueUsers!.childByAppendingPath(userName)
        user!.removeValue()
        println("NAME: \(myQueueName)")
    }
    // FireBase Callbacks
    func setupFirebaseCallbacks() {
        
        // Observe when client are added
        stmQueueUsers!.observeEventType(.ChildAdded, withBlock: { snapshot in
            self.incrementCounter()
        })
        
        // ... and changed
        stmQueueUsers!.observeEventType(.ChildChanged, withBlock: {
            snapshot in
            
        })
        
        // Observe when clients are removed
        stmQueueUsers!.observeEventType(.ChildRemoved, withBlock: {
            snapshot in
            self.decrementCounter()
        })
    }
    
}

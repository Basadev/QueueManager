//
//  MenuVC.swift
//  QueueManager
//
//  Created by Professional on 2015-06-07.
//  Copyright (c) 2015 Ntambwa. All rights reserved.
//

import UIKit
var queueName:String = String()
class MenuVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    var icons = ["clinic-100","saaq","passport","immigration","university","cableCompany","transport","gouv"]
    var iconsLabels = ["CLINICS","SAAQ","PASSPORT","IMMIGRATION","UNIVERSITIES","CABLE COMPANIES","TRANSPORT","GOV. OFFICES"]
    
    var servicesList = ["clinic","saaq","passport","immigration","university","cableCompany","transport","gouv"]
    
    var queueMRoot:Firebase?
    var servicesRef:Firebase?
    var queue:Firebase?
    var currentService:Firebase?
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
        
        queueMRoot = Firebase(url: "https://livequeue.firebaseio.com/")
        servicesRef = queueMRoot!.childByAppendingPath("services")
        
        //queue = servicesRef!.childByAppendingPath("queue")
        
    }
    
    //Mark - UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return icons.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! UICollectionViewCell
        
        var imageView: UIImageView = (cell.contentView.viewWithTag(10) as! UIImageView);
        imageView.image = UIImage(named:icons[indexPath.row])
        (cell.contentView.viewWithTag(11) as! UILabel).text = iconsLabels[indexPath.row]
        
        //imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, imageView.frame.size.width, 55);
        //if (indexPath.row == 2){
        var frame:CGRect = imageView.frame
        frame.size.height = 55
        imageView.frame = frame;
        //}
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView,
        didSelectItemAtIndexPath indexPath: NSIndexPath) {
            println("\(indexPath.row)");
             let queueString = "/queue"
            queueName = "\(servicesList[indexPath.row])\(queueString)"
            //currentService = queueMRoot!.childByAppendingPath( "\(servicesList[indexPath.row]) \(queueString)")
            println("NAME: \(queueName)")
            
            let queueVC = self.storyboard!.instantiateViewControllerWithIdentifier("queueVC") as! QueueStateVC
            queueVC.myQueueName = queueName
            self.navigationController!.pushViewController(queueVC, animated: true)
            
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        /*if segue.identifier == "gotoQstate"
        {
            if let destinationVC = segue.destinationViewController as? QueueStateVC{
                
                var indexPath: Int? = self.menuCollectionView.indexPathsForSelectedItems()
                let queueString = "queue"
                var path: String? = servicesList[indexPath]
                queueName = "\(servicesList[indexPath]) \(queueString)"
                
                println("NAME: \(queueName)")
                destinationVC.myQueueName = queueName
            }
        }*/
    
        
    }
    

}

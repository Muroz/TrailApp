//
//  FirstViewController.swift
//  eastCoastTrailApp
//
//  Created by Diego Zuluaga on 2017-04-25.
//  Copyright © 2017 Diego Zuluaga. All rights reserved.
//

import UIKit
import CoreMotion

class PlaceTableViewCell: UITableViewCell {
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var imagesView: UIImageView!
}

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var currentState: UILabel!
    @IBOutlet weak var steps: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var popViewController: PopUpViewController!
    
    var days:[String] = []
    var stepsTaken:[Int] = []
    
    var titleX = ""
    var imgName = ""
    
    let activityManager = CMMotionActivityManager()
    let pedoMeter = CMPedometer()
    
    var placemarks: [String] = ["spout.jpg", "lamanche.jpg", "capeSpear.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Storyboard
//        let viewControllerStoryboardId = "PopUpViewController"
//        let storyboardName = "Main"
//        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
//        popViewController = (storyboard.instantiateViewController(withIdentifier: viewControllerStoryboardId) as UIViewController!) as! PopUpViewController!
//        //popViewController = PopUpViewController(nibName: "PopUpViewController", bundle: bundle)
//        popViewController.title = "This is a popup view"
//        popViewController.showInView(aView: self.view, withImage: UIImage(named: "eastcoastt1.jpg"), withMessage: "You just triggered a great popup window", animated: true)
        
        
        
        var cal = Calendar.current
        var comps = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        let timeZone = NSTimeZone.system
        cal.timeZone = timeZone
        
        let midnightOfToday = cal.date(from: comps)!

        
        
        if(CMMotionActivityManager.isActivityAvailable()){
            print("no see")
            self.activityManager.startActivityUpdates(to: OperationQueue.main, withHandler: { (data: CMMotionActivity!) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    if(data.stationary == true){
                        self.currentState.text = "Stationary"
//                        self.stateImageView.image = UIImage(named: "Sitting")
                    } else if (data.walking == true){
                        self.currentState.text = "Walking"
                        //self.stateImageView.image = UIImage(named: "Walking")
                    } else if (data.running == true){
                        self.currentState.text = "Running"
                       // self.stateImageView.image = UIImage(named: "Running")
                    } else if (data.automotive == true){
                       // self.activityState.text = "Automotive"
                    }
                })
                
            })
        }
        
        
        
        if(CMPedometer.isStepCountingAvailable()){
            print("ese")
//            let fromDate = NSDate(timeIntervalSinceNow: -86400 * 7)
//            self.pedoMeter.queryPedometerData(from: fromDate as Date, to: NSDate() as Date) { (data : CMPedometerData!, error) -> Void in
//                DispatchQueue.main.async(execute: { () -> Void in
//                    if(error == nil){
//                        self.steps.text = "\(data.numberOfSteps)"
//                    }
//                })
//                
//            }
            //self.pedoMeter.queryPedometerData(from: midnightOfToday, to: now, withHandler: <#T##CMPedometerHandler##CMPedometerHandler##(CMPedometerData?, Error?) -> Void#>)
            self.pedoMeter.startUpdates(from: midnightOfToday) { (data: CMPedometerData!, error) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    if(error == nil){
                        self.steps.text = "\(data.numberOfSteps)"
                    }
                })
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placemarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "MyTestCell") as! PlaceTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTestCell") as! PlaceTableViewCell
        cell.infoLabel.text = placemarks[indexPath.row]
        //"Row \(indexPath.row)"
        //cell.detailTextLabel?.text = "Subtitle \(indexPath.row)"
        
        let image : UIImage = UIImage(named: placemarks[indexPath.row])!

        //var frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        
        
        
        cell.imagesView.image = image
        cell.backgroundColor = UIColor(patternImage: image).withAlphaComponent(0.3)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        imgName = placemarks[indexPath.row]
        titleX = placemarks[indexPath.row]
        performSegue(withIdentifier: "infoWindow", sender: self)
        
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: imgName)?.draw(in: self.view.bounds)
        let image: UIImage = (UIGraphicsGetImageFromCurrentImageContext())!
        UIGraphicsEndImageContext()
        if segue.identifier == "infoWindow" {
            // Setup new view controller
            let info:infoViewController = segue.destination as! infoViewController
            info.titleString = titleX
            info.textString = "text goes here"
            info.view.backgroundColor = UIColor(patternImage: image).withAlphaComponent(0.8)

            
        }
    }



}


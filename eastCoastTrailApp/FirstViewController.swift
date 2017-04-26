//
//  FirstViewController.swift
//  eastCoastTrailApp
//
//  Created by Diego Zuluaga on 2017-04-25.
//  Copyright © 2017 Diego Zuluaga. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var imagesView: UIImageView!
}

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var popViewController: PopUpViewController!
    
    var placemarks: [String] = ["spout.jpg", "lamanche.jpg", "capeSpear.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Storyboard
        let viewControllerStoryboardId = "PopUpViewController"
        let storyboardName = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        popViewController = (storyboard.instantiateViewController(withIdentifier: viewControllerStoryboardId) as UIViewController!) as! PopUpViewController!
        //popViewController = PopUpViewController(nibName: "PopUpViewController", bundle: bundle)
        popViewController.title = "This is a popup view"
        popViewController.showInView(aView: self.view, withImage: UIImage(named: "eastcoastt1.jpg"), withMessage: "You just triggered a great popup window", animated: true)

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
        cell.infoLabel.text = "Row \(indexPath.row)"
        //cell.detailTextLabel?.text = "Subtitle \(indexPath.row)"
        
        let image : UIImage = UIImage(named: placemarks[indexPath.row])!

        //var frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        
        
        
        cell.imagesView.image = image
   
        
        return cell
    }
    
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100
    }



}


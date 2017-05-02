//
//  packageViewController.swift
//  eastCoastTrailApp
//
//  Created by Diego Zuluaga on 2017-05-02.
//  Copyright © 2017 Diego Zuluaga. All rights reserved.
//

import Foundation
import UIKit


class PackageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var packageView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "MyTestCell")
        //"Row \(indexPath.row)"
        cell.detailTextLabel?.text = "Subtitle \(indexPath.row)"
        
        
        cell.textLabel?.text = "Row \(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "first", sender: self)
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "first" {
            // Setup new view controller
            let first:UITabBarController = segue.destination as! UITabBarController

            
            
        }
    }


}

//
//  SecondViewController.swift
//  eastCoastTrailApp
//
//  Created by Diego Zuluaga on 2017-04-25.
//  Copyright © 2017 Diego Zuluaga. All rights reserved.
//

import UIKit
import Mapbox

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let styleURL = URL(string: "https://www.mapbox.com/ios-sdk/files/mapbox-raster-v8.json")

        let mapView = MGLMapView(frame: view.bounds,  styleURL: styleURL)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Set the map’s center coordinate and zoom level.
        mapView.setCenter(CLLocationCoordinate2D(latitude: 47.5615, longitude: -52.7126), zoomLevel: 15, animated: false)
        view.addSubview(mapView)
        
//        let btn: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 50, height: 50))
//        btn.backgroundColor = UIColor.green
//        btn.setTitle("+", for: .normal)
//        btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//        btn.tag = 1
//        view.addSubview(btn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


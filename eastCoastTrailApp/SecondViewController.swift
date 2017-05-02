//
//  SecondViewController.swift
//  eastCoastTrailApp
//
//  Created by Diego Zuluaga on 2017-04-25.
//  Copyright © 2017 Diego Zuluaga. All rights reserved.
//

import UIKit
import Mapbox
import Foundation

class SecondViewController: UIViewController, MGLMapViewDelegate {
    var mapView: MGLMapView!
    var popup: UILabel?
    
    
//    var timer: Timer?
//    var polylineSource: MGLShapeSource?
//    var currentIndex = 1
//    var allCoordinates: [CLLocationCoordinate2D]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MGLMapView(frame: view.bounds)
        mapView.styleURL = MGLStyle.lightStyleURL(withVersion: 9)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.tintColor = .darkGray
        
        mapView.setCenter(CLLocationCoordinate2D(latitude:47.5701, longitude: -52.6819), zoomLevel: 12, animated: false)
        
        mapView.delegate = self
        view.addSubview(mapView)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
    }
    
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        
        // Parse the GeoJSON data.
        DispatchQueue.global().async {
            guard let url = Bundle.main.url(forResource: "metro-line", withExtension: "geojson") else { return }
            
            let data = try! Data(contentsOf: url)
            
            DispatchQueue.main.async {
                self.drawShapeCollection(data: data)
            }
        }
//        addLayer(to: style)
//        animatePolyline()
        
    }
    
    
    
    func drawShapeCollection(data: Data) {
        guard let style = self.mapView.style else { return }
        
        // Use [MGLShape shapeWithData:encoding:error:] to create a MGLShapeCollectionFeature from GeoJSON data.
        let feature = try! MGLShape(data: data, encoding: String.Encoding.utf8.rawValue) as! MGLShapeCollectionFeature
        
        // Create source and add it to the map style.
        let source = MGLShapeSource(identifier: "transit", shape: feature, options: nil)
        style.addSource(source)
        
        // Create station style layer.
        let circleLayer = MGLCircleStyleLayer(identifier: "stations", source: source)
        
        // Use a predicate to filter out non-points.
        
        circleLayer.predicate = NSPredicate(format: "TYPE = 'Station'")
        circleLayer.circleColor = MGLStyleValue(rawValue: .red)
        circleLayer.circleRadius = MGLStyleValue(rawValue: 6)
        circleLayer.circleStrokeWidth = MGLStyleValue(rawValue: 2)
        circleLayer.circleStrokeColor = MGLStyleValue(rawValue: .black)
    
        // Create line style layer.
        let lineLayer = MGLLineStyleLayer(identifier: "rail-line", source: source)
        
        // Use a predicate to filter out the stations.
        lineLayer.predicate = NSPredicate(format: "TYPE = 'Rail line'")
        lineLayer.lineColor = MGLStyleValue(rawValue: .red)
        lineLayer.lineWidth = MGLStyleValue(rawValue: 2)
        
        // Add style layers to the map view's style.
        style.addLayer(circleLayer)
        style.insertLayer(lineLayer, below: circleLayer)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func handleTap(_ tap: UITapGestureRecognizer) {
        
        if tap.state == .ended {
            showPopup(false, animated: false)
            print("im tapping")
            
            let point = tap.location(in: tap.view)
            print(point)
            let width = CGFloat(50.2)

            let rect = CGRect(x: point.x - width / 2, y: point.y - width / 2, width: width, height: width)
            let stations = mapView.visibleFeatures(in: rect, styleLayerIdentifiers:["stations"])
            
            if stations.count > 0 {
                let station = stations.first!
    
                    popup = UILabel(frame: CGRect(x:0, y:0, width: 100, height: 40))
                    popup!.backgroundColor = UIColor.white.withAlphaComponent(0.9)
                    popup!.layer.cornerRadius = 4
                    popup!.layer.masksToBounds = true
                    popup!.textAlignment = .center
                    popup!.lineBreakMode = .byTruncatingTail
                    popup!.font = UIFont.systemFont(ofSize: 16)
                    popup!.textColor = UIColor.black
                    popup!.alpha = 0
                    view.addSubview(popup!)
                popup!.text = (station.attribute(forKey: "NAME")! as! String)
  
                let point = mapView.convert(station.coordinate, toPointTo: mapView)
                popup!.center = CGPoint(x: point.x, y: point.y - 50)
                if popup!.alpha < 1 {
                    showPopup(true, animated: true)
                }
            }
            
        }
    }
    
    func mapViewRegionIsChanging(_ mapView: MGLMapView) {
        showPopup(false, animated: false)
    }
    
    func showPopup(_ shouldShow: Bool, animated: Bool) {
        let alpha: CGFloat = (shouldShow ? 1 : 0)
        if animated {
            UIView.animate(withDuration: 0.25) { [unowned self] in
                self.popup?.alpha = alpha
            }
        } else {
            popup?.alpha = alpha
        }
    }


}

//
//  SecondViewController.swift
//  eastCoastTrailApp
//
//  Created by Diego Zuluaga on 2017-04-25.
//  Copyright © 2017 Diego Zuluaga. All rights reserved.
//

import UIKit
import Mapbox

class SecondViewController: UIViewController, MGLMapViewDelegate {
    var mapView: MGLMapView!
    
    
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
        
        //new code
       // allCoordinates = coordinates()
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
    
    
//    //new code
//    func addLayer(to style: MGLStyle) {
//        // Add an empty MGLShapeSource, we’ll keep a reference to this and add points to this later.
//        let source = MGLShapeSource(identifier: "polyline", shape: nil, options: nil)
//        style.addSource(source)
//        polylineSource = source
//        
//        // Add a layer to style our polyline.
//        let layer = MGLLineStyleLayer(identifier: "polyline", source: source)
//        layer.lineJoin = MGLStyleValue(rawValue: NSValue(mglLineJoin: .round))
//        layer.lineCap = MGLStyleValue(rawValue: NSValue(mglLineCap: .round))
//        layer.lineColor = MGLStyleValue(rawValue: UIColor.red.withAlphaComponent(0.5))
//        layer.lineWidth = MGLStyleFunction(interpolationMode: .exponential,
//                                           cameraStops: [14: MGLConstantStyleValue<NSNumber>(rawValue: 5),
//                                                         18: MGLConstantStyleValue<NSNumber>(rawValue: 20)],
//                                           options: [.defaultValue : MGLConstantStyleValue<NSNumber>(rawValue: 1.5)])
//        style.addLayer(layer)
//    }
//    
//    func animatePolyline() {
//        currentIndex = 1
//        
//        // Start a timer that will simulate adding points to our polyline. This could also represent coordinates being added to our polyline from another source, such as a CLLocationManagerDelegate.
//        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
//    }
//    
//    func tick() {
//        if currentIndex > allCoordinates.count {
//            timer?.invalidate()
//            timer = nil
//            return
//        }
//        
//        // Create a subarray of locations up to the current index.
//        let coordinates = Array(allCoordinates[0..<currentIndex])
//        
//        // Update our MGLShapeSource with the current locations.
//        updatePolylineWithCoordinates(coordinates: coordinates)
//        
//        currentIndex += 1
//    }
//    
//    func updatePolylineWithCoordinates(coordinates: [CLLocationCoordinate2D]) {
//        var mutableCoordinates = coordinates
//        
//        let polyline = MGLPolylineFeature(coordinates: &mutableCoordinates, count: UInt(mutableCoordinates.count))
//        
//        // Updating the MGLShapeSource’s shape will have the map redraw our polyline with the current coordinates.
//        polylineSource?.shape = polyline
//    }
//    
//    func coordinates() -> [CLLocationCoordinate2D] {
//        return [
//            (
//                -52.69512891769409, 47.572515860486284
//            ),
//            (
//                -52.69467830657959,
//                47.57281986733871
//            ),
//            (
//                -52.694056034088135,
//                47.57290672611525
//            ),
//            (
//                -52.69326210021973,
//                47.57276196140763
//            ),
//            (
//                -52.69246816635132,
//                47.57270405541254
//            ),
//            (
//                -52.69154548645019,
//                47.57263167282865
//            ),
//            (
//                -52.69120216369628,
//                47.572429001061444
//            ),
//            (
//                -52.69047260284424,
//                47.57226975840844
//            ),
//            (
//                -52.68976449966431,
//                47.57206708524059
//            ),
//            (
//                -52.689034938812256,
//                47.57198022507143
//            ),
//            (
//                -52.68813371658325,
//                47.572038131866876
//            ),
//            (
//                -52.68770456314087,
//                47.57200917847715
//            ),
//            (
//                -52.68712520599365,
//                47.57154592206455
//            ),
//            (
//                -52.68648147583008,
//                47.57135772297638
//            ),
//            (
//                -52.68564462661743,
//                47.57125638472572
//            ),
//            (
//                -52.68485069274902,
//                47.57112609240098
//            ),
//            (
//                -52.68375635147095,
//                47.5705180572663
//            ),
//            (
//                -52.68296241760254,
//                47.57046014879007
//            ),
//            (
//                -52.68223285675049,
//                47.5706049198606
//            ),
//            (
//                -52.68115997314453,
//                47.57141563046015
//            ),
//            (
//                -52.680795192718506,
//                47.57148801472485
//            ),
//            (
//                -52.680602073669434,
//                47.571212953986816
//            ),
//            (
//                -52.68013000488281,
//                47.57080759868703
//            ),
//            (
//                -52.68002271652221,
//                47.5710247537021
//            ),
//            (
//                -52.67993688583374,
//                47.57116952321189
//            ),
//            (
//                -52.67955064773559,
//                47.571212953986816
//            ),
//            (
//                -52.679293155670166,
//                47.5714735378799
//            ),
//            (
//                -52.67914295196533,
//                47.57122743090377
//            ),
//            (
//                -52.678391933441155,
//                47.571212953986816
//            ),
//            (
//                -52.6784348487854,
//                47.57103923067108
//            ),
//            (
//                -52.67766237258911,
//                47.57053253437536
//            ),
//            (
//                -52.67770528793335,
//                47.570315377319346
//            ),
//            (
//                -52.677319049835205,
//                47.56986658321691
//            ),
//            (
//                -52.677297592163086,
//                47.56915719114685
//            ),
//            (
//                -52.67736196517944,
//                47.568940028388184
//            ),
//            (
//                -52.677297592163086,
//                47.56863599901331
//            ),
//            (
//                -52.67757654190063,
//                47.56833196787361
//            ),
//            (
//                -52.67772674560546,
//                47.56798450155295
//            ),
//            (
//                -52.67807006835937,
//                47.567839723239025
//            ),
//            (
//                -52.67860651016235,
//                47.567912112446024
//            ),
//            (
//                -52.67873525619507,
//                47.56795554592218
//            ),
//            (
//                -52.67890691757202,
//                47.568201668273495
//            ),
//            (
//                -52.67914295196533,
//                47.568027934969116
//            ),
//            (
//                -52.67935752868652,
//                47.56815823500143
//            ),
//            (
//                -52.679593563079834,
//                47.568187190520135
//            ),
//            (
//                -52.679872512817376,
//                47.56794106810079
//            ),
//            (
//                -52.68062353134155,
//                47.5681727127628
//            ),
//            (
//                -52.68137454986572,
//                47.56801345716771
//            ),
//            (
//                -52.68210411071777,
//                47.56824510150957
//            ),
//            (
//                -52.68244743347168,
//                47.56808584613459
//            ),
//            (
//                -52.683048248291016,
//                47.56792659027541
//            ),
//            (
//                -52.6833701133728,
//                47.56805689055986
//            ),
//            (
//                -52.68349885940552,
//                47.5682595792469
//            ),
//            (
//                -52.68373489379883,
//                47.56831749015628
//            ),
//            (
//                -52.6839280128479,
//                47.56841883409362
//            ),
//            (
//                -52.68418550491333,
//                47.5682885347096
//            ),
//            (
//                -52.68450736999512,
//                47.56804241276647
//            ),
//            (
//                -52.6852798461914,
//                47.5676949445249
//            ),
//            (
//                -52.686073780059814,
//                47.567767333931975
//            ),
//            (
//                -52.68667459487915,
//                47.56765151083265
//            ),
//            (
//                -52.6874041557312,
//                47.56752120953971
//            ),
//            (
//                -52.6877474784851,
//                47.56789763461261
//            ),
//            (
//                -52.68813371658325,
//                47.56808584613459
//            ),
//            (
//                -52.68899202346802,
//                47.56831749015628
//            ),
//            (
//                -52.689893245697014,
//                47.56872286472908
//            ),
//            (
//                -52.68991470336914,
//                47.56901241607444
//            ),
//            (
//                -52.69025802612305,
//                47.56917166863208
//            ),
//            (
//                -52.69066572189331,
//                47.56904137112095
//            ),
//            (
//                -52.69064426422119,
//                47.569562559220586
//            ),
//            (
//                -52.69115924835205,
//                47.56970733277228
//            ),
//            (
//                -52.69163131713867,
//                47.56986658321691
//            ),
//            (
//                -52.69291877746582,
//                47.570242991433915
//            ),
//            (
//                -52.693819999694824,
//                47.5704891030362
//            ),
//            (
//                -52.69442081451416,
//                47.57066282817676
//            ),
//            (
//                -52.69493579864502,
//                47.571212953986816
//            ),
//            (
//                -52.69497871398926,
//                47.57177755078309
//            ),
//            (
//                -52.694528102874756,
//                47.572211851869085
//            ),
//            (
//                -52.69401311874389,
//                47.5724869073607
//            ),
//            (
//                -52.6939058303833,
//                47.57271853191732
//            )
//            
//
//            ].map({CLLocationCoordinate2D(latitude: $0.1, longitude: $0.0)})
//    }
//

}


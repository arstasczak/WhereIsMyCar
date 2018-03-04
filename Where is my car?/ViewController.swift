//
//  ViewController.swift
//  Where is my car?
//
//  Created by Student on 03.01.2018.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var addCarButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var autopin : MyAutoPin?
    var oldpin : MyAutoPin?
    var oldRegion: CLCircularRegion?
    var newRegion: CLCircularRegion?
    var circle: MKCircle?

    @IBAction func addCar(_ sender: Any) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        oldpin = autopin
        oldRegion = newRegion
        autopin = MyAutoPin(title: "Moje auto", coordinate: CLLocationManager().location!.coordinate)

        if (oldpin != nil){
            mapView.removeAnnotation(oldpin!)
        }
        if(oldRegion != nil){
            locationManager.stopMonitoring(for: oldRegion!)
            remRegion(region: oldRegion!)
            mapView.remove(circle!)
        }
        newRegion = createRegion(coordinates: (autopin?.coordinate)!, title: (autopin?.title)!)
        locationManager.startMonitoring(for: newRegion!)
        locationManager.requestState(for: newRegion!)
        mapView.addAnnotation(autopin!)
        circle = MKCircle(center: (autopin?.coordinate)!, radius: 100)
        mapView.add(circle!)
        mapView.userTrackingMode = MKUserTrackingMode.follow
    }
    
    func remRegion(region: CLCircularRegion){
        locationManager.stopMonitoring(for: region)
        
    }
    func createRegion(coordinates: CLLocationCoordinate2D, title: String) -> CLCircularRegion{
        let region = CLCircularRegion(center: coordinates, radius: 100, identifier: "Mój region")
        region.notifyOnExit = true
        region.notifyOnEntry = true
        print("dodano region")
        return region;
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = UIColor.red
        circleRenderer.lineWidth = 1.0
        return circleRenderer
    }
    
    override func viewDidLoad() {
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = MKUserTrackingMode.follow
        locationManager.delegate = self
        mapView.delegate = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


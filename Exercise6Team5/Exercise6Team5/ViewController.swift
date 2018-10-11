//
//  ViewController.swift
//  Exercise6Team5
//
//  Created by ubicomp5 on 10/11/18.
//  Copyright © 2018 cpl.ubicomp. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var detailMap: MKMapView!
    
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let companyLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.latitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegion(center: companyLocation, span: span)
        
        detailMap.setRegion(region, animated: true)
        
        self.detailMap.showsUserLocation = true
        
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = location
//        annotation.title =
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Logic to display location on map using 'manager' as the delegate
        
        manager.delegate = self
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


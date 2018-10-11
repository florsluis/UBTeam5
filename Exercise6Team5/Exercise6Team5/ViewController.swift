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
    
    var selectedLocation = Locations()

    @IBOutlet weak var detailMap: MKMapView!
    
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let companyLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.latitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegion(center: companyLocation, span: span)
        
        detailMap.setRegion(region, animated: true)
        
        

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Logic to display location on map using 'manager' as the delegate
        self.title = selectedLocation.company
        manager.delegate = self
        let location = selectedLocation
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let companyLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(selectedLocation.hq_latitude, selectedLocation.hq_longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegion(center: companyLocation, span: span)
        
        detailMap.setRegion(region, animated: true)
        let companyLocationCL: CLLocation = CLLocation(latitude: selectedLocation.hq_latitude, longitude: selectedLocation.hq_longitude)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = companyLocation
        annotation.title = selectedLocation.company
        CLGeocoder().reverseGeocodeLocation(companyLocationCL) { (placemark, error) in
            if error != nil {
                print("Error")
            } else {
                if let place = placemark?[0] {
                    if let city = place.locality {
                        if let state = place.administrativeArea {
                            if let country = place.country {
                                annotation.subtitle = "\(city), \(state), \(country)"
                            }
                            
                            
                        }
                    }
                    
                }
            }
        }
//        annotation.subtitle =
        detailMap.addAnnotation(annotation)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


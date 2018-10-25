//
//  ViewController.swift
//  PA2Team5
//
//  Created by ubicomp5 on 10/25/18.
//  Copyright © 2018 cpl.ubicomp. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    var contactData = Contact()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        generateMap()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateMap() {
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let location = CLLocationCoordinate2DMake(contactData.hq_latitude, contactData.hq_longitude)
        let region = MKCoordinateRegionMake(location, span)
        
        let location2 = CLLocation(latitude: self.contactData.hq_latitude, longitude: self.contactData.hq_longitude)
        
        CLGeocoder().reverseGeocodeLocation(location2) {
            (placemark, error) in if error != nil {
                print("ERROR")
            } else {
                if let place = placemark?[0] {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    annotation.title = "\(self.contactData.company)"
                    annotation.subtitle = "\(place.locality!), \(place.administrativeArea!), \(place.isoCountryCode!)"
                }
            }
        }
    }
    
}


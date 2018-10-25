//
//  ViewController.swift
//  Exercise6_solution
//
//  Created by Emtiaz Ahmed on 10/10/18.
//  Copyright © 2018 Emtiaz Ahmed. All rights reserved.
//

import UIKit
import MapKit



class ViewController: UIViewController {
    var selectData = companyList()

    @IBOutlet weak var mpView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectData.company

        generateMap()
        

    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateMap(){


        let span = MKCoordinateSpanMake(0.01,0.01)
        let myLoc = CLLocationCoordinate2DMake(selectData.hq_latitude, selectData.hq_longitude)
        let region = MKCoordinateRegionMake(myLoc, span)
                mpView.setRegion(region, animated: true)
        self.mpView.showsUserLocation = true
        
        
        let loc = CLLocation(latitude: self.selectData.hq_latitude, longitude: self.selectData.hq_longitude)
        CLGeocoder().reverseGeocodeLocation(loc) { (placemark, error) in
            if error != nil {
                print("THERE WAS ERROR")
            }
            else {
                if let place = placemark?[0] {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = myLoc
                    annotation.title = "\(self.selectData.company)"

                    annotation.subtitle = "\(place.locality!), \(place.administrativeArea!), \(place.isoCountryCode!)"
                    DispatchQueue.main.async {
                        self.mpView.addAnnotation(annotation)
                    }
                }
            }
        }
    }
    
    



}


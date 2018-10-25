//
//  ViewController.swift
//  PA2Team5
//
//  Created by ubicomp5 on 10/25/18.
//  Copyright © 2018 cpl.ubicomp. All rights reserved.
//



import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var imageLogo: UIImageView!
    var contactData = Contact()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func locationButton(_ sender: Any) {
        performSegue(withIdentifier: "detailsToMap", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let mapSegue = segue.destination as! MapViewController
        mapSegue.contactData = self.contactData
    }
    
    
}


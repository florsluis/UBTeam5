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
    
    //Mark - Data Labels
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var about: UILabel!
    
    var contactData = Contact()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Need to populate the data
        id.text = "id: \(contactData._id)"
        phone.text = "phone: \(contactData.phone)"
        email.text = "email: \(contactData.email)"
        age.text = "age: \(contactData.age)"
        about.text = "about: \(contactData.about)"
        
        let url = contactData.logo
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.imageLogo.image = UIImage(data: data!)
            }
        }).resume()
        
        
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


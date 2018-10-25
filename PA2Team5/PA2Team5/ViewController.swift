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
    var context = CIContext()
    var LogoImage: UIImage?
    
    func convertToVintage(image: UIImage, context: CIContext) -> UIImage
    {
        let inputCIImage = CIImage(image: image)
        let filter = CIFilter(name: "CIPhotoEffectInstant")!
        filter.setValue(inputCIImage, forKey: kCIInputImageKey)
        let ciImage = filter.outputImage
        let cgImage = context.createCGImage(ciImage!, from: (ciImage?.extent)!)
        return UIImage(cgImage: cgImage!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Need to populate the data
        id.text = "id: \(contactData._id)"
        phone.text = "phone: \(contactData.phone)"
        email.text = "email: \(contactData.email)"
        age.text = "age: \(contactData.age)"
        about.text = "about: \(contactData.about)"
        imageLogo.image = LogoImage
        imageLogo.image = convertToVintage(image: imageLogo.image!, context: context)
        
        
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


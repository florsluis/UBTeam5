//
//  ViewController.swift
//  Exercise5solution
//
//  Created by Emtiaz Ahmed on 10/3/18.
//  Copyright © 2018 Emtiaz Ahmed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var language = Languages()

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblWebsite: UILabel!
    @IBOutlet weak var lblAbout: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = language.name
        
        lblAbout.text = language.about
        lblWebsite.text = language.website
        
        
        URLSession.shared.dataTask(with: language.logo, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.imgLogo.image = UIImage(data: data!)
            }
        }).resume()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


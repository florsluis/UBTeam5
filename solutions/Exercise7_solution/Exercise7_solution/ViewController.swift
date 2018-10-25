//
//  ViewController.swift
//  Exercise7_solution
//
//  Created by Emtiaz Ahmed on 10/16/18.
//  Copyright © 2018 Emtiaz Ahmed. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    
    @IBOutlet weak var imgView: UIImageView!
    
    var imageArray: [UIImage] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnLoad(_ sender: Any) {
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
        
        
    }
    
    
    @IBAction func btnFilter(_ sender: Any) {
        var imageArray: [UIImage] = []
        
       
      
        if imgView.image != nil {
            imageArray.append(imgView.image!)
            imageArray.append(imgView.image!)
            imageArray.append(imgView.image!)
            self.imageArray = imageArray

            print(imageArray.count)
            self.performSegue(withIdentifier: "segueViewToFilter", sender: self)
//
        }
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imgView.image = image
            
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueViewToFilter") {
            let varSegue = segue.destination as! FilterTableViewController
            varSegue.arrayOfImage = self.imageArray
        }
    }
    
    
}


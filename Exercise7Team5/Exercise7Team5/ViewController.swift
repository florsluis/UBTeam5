//
//  ViewController.swift
//  Exercise7Team5
//
//  Created by ubicomp5 on 10/18/18.
//  Copyright © 2018 cpl.ubicomp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func importImageButton() {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary //or camera
        image.allowsEditing = false
        self.present(image, animated : true)
    }
    
    @IBAction func loadImageButton(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary //or camera
        image.allowsEditing = false
        self.present(image, animated : true)
        
    }
    
    @IBAction func filterImageButton(_ sender: Any) {
        //Apply filters
        //store into array
        //call segue and pass array
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = image
        } else {
            //Error message
        }
        self.dismiss(animated : true, completion : nil)
    }


//

}


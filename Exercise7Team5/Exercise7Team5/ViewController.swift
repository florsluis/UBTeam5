//
//  ViewController.swift
//  Exercise7Team5
//
//  Created by ubicomp5 on 10/18/18.
//  Copyright © 2018 cpl.ubicomp. All rights reserved.
//

import UIKit
import UserNotifications

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
    
    @IBAction func btnFilter(_ sender: Any) {
        performSegue(withIdentifier: "filterSegue", sender: self)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filterSegue" {
            let filterSegue = segue.destination as! TableController
             filterSegue.originalImage = imageView.image!
    }

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
    //link the notification trigger
//    @IBAction func triggeredNotification(_ sender: Any)
//    {
//        let content = UNMutableNotificationContent()
//        content.title = "Alert"
//        content.subtitle = "5 seconds have passed"
//        content.body = "It's done"
//        content.badge = 1
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//        let request = UNNotificationRequest(identifier: "timerComplete", content: content, trigger: trigger)
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//    }



}


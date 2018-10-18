//
//  ViewController.swift
//  Exercise7Team5
//
//  Created by ubicomp5 on 10/18/18.
//  Copyright © 2018 cpl.ubicomp. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound])
        { (granted, error) in
            //Notification authorization fail or accept
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //link the notification trigger
    @IBAction func triggeredNotification(_ sender: Any)
    {
        let content = UNMutableNotificationContent()
        content.title = "Alert"
        content.subtitle = "5 seconds have passed"
        content.body = "It's done"
        content.badge = 1
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "timerComplete", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

}


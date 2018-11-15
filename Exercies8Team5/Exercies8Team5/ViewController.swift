//
//  ViewController.swift
//  Exercies8Team5
//
//  Created by Flores, Luis on 11/8/18.
//  Copyright © 2018 ubicomp5. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    var motionManager = CMMotionManager()
    var accelMotionManager = CMMotionManager()
    @IBOutlet weak var vehicleImage: UIImageView!
    @IBOutlet weak var bottomBorder: UIView!
    @IBOutlet weak var leftBorder: UIView!
    @IBOutlet weak var topBorder: UIView!
    @IBOutlet weak var rightBorder: UIView!
    var dx: CGFloat = 0
    var dy: CGFloat = 0
    var gameTimer: Timer!
    let updateRate: Double = 1/20
    var point: CGPoint = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
        gameTimer = Timer.scheduledTimer(timeInterval: updateRate, target: self, selector: #selector(moveBox), userInfo: nil, repeats: true)
    }
    
    
    @objc func moveBox () {
        point = vehicleImage.center
        if let accelerometerData = accelMotionManager.accelerometerData {
            dx = CGFloat(accelerometerData.acceleration.x)
            dy = CGFloat(accelerometerData.acceleration.y)
            vehicleImage.frame.origin.y += dy * 5
            vehicleImage.frame.origin.x -= dx * 5
        }

        if (vehicleImage.frame.origin.x > UIScreen.main.bounds.width - vehicleImage.frame.width)
        {
            vehicleImage.backgroundColor = topBorder.backgroundColor
            vehicleImage.frame.origin.x = UIScreen.main.bounds.width - vehicleImage.frame.width
        }
        else if (vehicleImage.frame.origin.x < 0)
        {
            vehicleImage.backgroundColor = bottomBorder.backgroundColor
            point = vehicleImage.center
            vehicleImage.image = UIImage(named: "car")
            vehicleImage.center = point
            vehicleImage.frame.origin.x = 0
        }
        if (vehicleImage.frame.origin.y > UIScreen.main.bounds.height - vehicleImage.frame.height)
        {
            vehicleImage.backgroundColor = rightBorder.backgroundColor
            vehicleImage.frame.origin.y = UIScreen.main.bounds.height - vehicleImage.frame.height
        }
        else if (vehicleImage.frame.origin.y < 0)
        {
            vehicleImage.backgroundColor = leftBorder.backgroundColor
            vehicleImage.frame.origin.y = 0
        }
    }
    
    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    override func becomeFirstResponder() -> Bool {
        return true
    }
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            self.view.backgroundColor = getRandomColor()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        accelMotionManager.accelerometerUpdateInterval = 0.01
        accelMotionManager.startAccelerometerUpdates()
        _ = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(moveBox), userInfo: nil, repeats: true)

    }

}


//
//  ViewController.swift
//  Exercise9Team5
//
//  Created by Flores, Luis on 11/15/18.
//  Copyright © 2018 ubicomp5. All rights reserved.
//

import UIKit
import CoreMotion
import Dispatch
import LocalAuthentication

class ViewController: UIViewController {
    let altimeter = CMAltimeter()
    @IBOutlet weak var relativeAltitudeLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var currentActivityLabel: UILabel!
    let activityManager = CMMotionActivityManager()
    private let pedometer = CMPedometer()
    private var shouldStartUpdating: Bool = false
    private var startDate: Date? = nil
    var alphaValue = 0.5
    var backgroundColor = UIColor(white: 1.0, alpha: 0.5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        relativeAltitudeLabel.text = ""
        stepsLabel.text = ""
        currentActivityLabel.text = ""
    }
    @IBAction func buttonStart(_ sender: Any) {
        let context:LAContext = LAContext()
        let calendar = Calendar.current
        let sevenDaysAgo = calendar.date(byAdding: .day, value: -7, to: Date())
        pedometer.queryPedometerData(from: sevenDaysAgo!, to: Date(), withHandler: { (data, Error) in
            if let peodemeterData = data {
            print(peodemeterData.numberOfSteps)
            }
        })

        
        self.startUpdating()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "We need your TouchID", reply: { (wasSuccessful, error) in
                if wasSuccessful {
                    self.startDate = Date()
                    guard let startDate = self.startDate else { return }
                    self.updateStepsCountLabelUsing(startDate: self.startDate!)
                    self.startUpdatingAltimeter()
                    self.startUpdatingSteps()
                    
                    self.startUpdating()
                    

                } else {
                    print("Failed")
                }
            })
        }
    }
    @IBAction func buttonStop(_ sender: Any) {
        stopUpdating()
        self.view.backgroundColor = UIColor.white
    }
    
    func startUpdatingAltimeter() {
        if CMAltimeter.isRelativeAltitudeAvailable() {
            altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main) { (data, error) in self.relativeAltitudeLabel.text = String(format:"%.4f", (data?.relativeAltitude.doubleValue)!)
                
                
                if (data!.relativeAltitude.doubleValue >= 1.0) {
                    self.alphaValue = 1.0
                } else if (data!.relativeAltitude.doubleValue <= -1.0) {
                    self.alphaValue = 0.0
                } else {
                    self.alphaValue = Double((0.5 * (data!.relativeAltitude.doubleValue)) + 0.5)
                }
                self.view.backgroundColor = UIColor(white: 1.0, alpha: CGFloat(self.alphaValue))
            }
        }
    }
    
    func startUpdatingSteps() {
        
    }
    
    private func stopUpdating() {
        activityManager.stopActivityUpdates()
        pedometer.stopUpdates()
        pedometer.stopEventUpdates()
        altimeter.stopRelativeAltitudeUpdates()
        
    }
    
    private func startUpdating() {
        if CMMotionActivityManager.isActivityAvailable() {
            startTrackingActivityType()
        } else {
            currentActivityLabel.text = "Not available"
        }
        
        if CMPedometer.isStepCountingAvailable() {
            startCountingSteps()
        } else {
            stepsLabel.text = "Not available"
        }
    }
    private func on(error: Error) {
        //handle error
    }
    
    private func updateStepsCountLabelUsing(startDate: Date) {
        pedometer.queryPedometerData(from: startDate, to: Date()) {
            [weak self] pedometerData, error in
            if let error = error {
                self?.on(error: error)
            } else if let pedometerData = pedometerData {
                DispatchQueue.main.async {
                    self?.stepsLabel.text = String(describing: pedometerData.numberOfSteps)
                }
            }
        }
    }
    
    private func startTrackingActivityType() {
        activityManager.startActivityUpdates(to: OperationQueue.main) {
            [weak self] (activity: CMMotionActivity?) in
            guard let activity = activity else { return }
            DispatchQueue.main.async {
                if activity.walking {
                    self?.currentActivityLabel.text = "Walking"
                } else if activity.stationary {
                    self?.currentActivityLabel.text = "Stationary"
                } else if activity.running {
                    self?.currentActivityLabel.text = "Running"
                } else if activity.automotive {
                    self?.currentActivityLabel.text = "Automotive"
                }
            }
        }
    }
    
    private func startCountingSteps() {
        pedometer.startUpdates(from: Date()) {
            [weak self] pedometerData, error in
            guard let pedometerData = pedometerData, error == nil else { return }
            
            DispatchQueue.main.async {
                self?.stepsLabel.text = pedometerData.numberOfSteps.stringValue
            }
        }
    }

}


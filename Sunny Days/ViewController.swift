//
//  ViewController.swift
//  Sunny Days
//
//  Created by Calvin Nisbet on 2015-04-24.
//  Copyright (c) 2015 Calvin Nisbet. All rights reserved.
//

import UIKit
import CoreLocation 

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    var dailyWeather: DailyWeather? {
        didSet {
            configureView()
        }
    }
    
    @IBOutlet weak var weatherImage: UIImageView?
    @IBOutlet weak var weatherSummary: UILabel?
    @IBOutlet weak var sunriseLabel: UILabel?
    @IBOutlet weak var sunsetLabel: UILabel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            configureView()
         }

    func configureView() {
        if let weather = dailyWeather {
            
            weatherImage?.image = weather.largeIcon
            weatherSummary?.text = weather.summary
            sunriseLabel?.text = weather.sunriseTime
            sunsetLabel?.text = weather.sunsetTime
            self.title = weather.day
        }
        if let buttonFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0) {
            let barButtonAttributesDictionary: [NSObject: AnyObject]? = [
                NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSFontAttributeName: buttonFont
            ]
            UIBarButtonItem.appearance().setTitleTextAttributes(barButtonAttributesDictionary, forState: .Normal)
        }
        
    }
   
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}





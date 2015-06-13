//
//  ViewController.swift
//  Sunny Days
//
//  Created by Calvin Nisbet on 2015-04-24.
//  Copyright (c) 2015 Calvin Nisbet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    private let apiKey = "beb199041f9a378c0e52ba94bd6ec194"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
        let forecastURL = NSURL(string: "25.705042,-80.429967", relativeToURL: baseURL)
        let sharedSession = NSURLSession.sharedSession()
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL!, completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
            
            if  (error == nil) {
            let dataObject = NSData(contentsOfURL: location!)
            let weatherDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil) as! NSDictionary
             
                let currentWeather = Current(weatherDictionary: weatherDictionary)
                println(currentWeather.summary)
                
            }
        })
        downloadTask.resume()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


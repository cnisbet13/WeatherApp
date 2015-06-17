//
//  ViewController.swift
//  Sunny Days
//
//  Created by Calvin Nisbet on 2015-04-24.
//  Copyright (c) 2015 Calvin Nisbet. All rights reserved.
//

import UIKit
import CoreLocation 

class ViewController: UIViewController {

    
    @IBOutlet var iconView: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var rainLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var refreshIndicator: UIActivityIndicatorView!
    
    private let apiKey = "beb199041f9a378c0e52ba94bd6ec194"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        refreshIndicator.hidden = true
        
    }

    
    func getUserLocation() -> Void {
        let manager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled(){
            manager.startUpdatingLocation()
        }
    }
    
    func getWeatherData() -> Void {
        
        getUserLocation()
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
        let forecastURL = NSURL(string: "25.705042,-80.429967", relativeToURL: baseURL)
        let sharedSession = NSURLSession.sharedSession()
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL!, completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
            
            if  (error == nil) {
                let dataObject = NSData(contentsOfURL: location!)
                let weatherDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil) as! NSDictionary
                
                let currentWeather = Current(weatherDictionary: weatherDictionary)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    println(weatherDictionary)
                    self.tempLabel.text = "\(currentWeather.temperature)"
                    self.iconView.image = currentWeather.icon!
                    self.timeLabel.text = "At \(currentWeather.currentTime!) it is"
                    self.humidityLabel.text = "\(currentWeather.humidity)"
                    self.rainLabel.text = "\(currentWeather.precipProbability)"
                    self.summaryLabel.text = "\(currentWeather.summary)"
                    
                    self.refreshIndicator.stopAnimating()
                    self.refreshIndicator.hidden = true
                    self.refreshButton.hidden = false
                })
            }
                else {
                let errorController = UIAlertController(title: "Error", message: "Sorry, unable to load data for some reason. Don't hate, try again soon!", preferredStyle:  .Alert)
                
                let okButton = UIAlertAction(title: "Sure", style: .Default, handler: nil)
                errorController.addAction(okButton)
                
                
                let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                errorController.addAction(cancelButton)
                
                
                self.presentViewController(errorController, animated: true, completion: nil)
                
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.refreshIndicator.stopAnimating()
                    self.refreshIndicator.hidden = true
                    self.refreshButton.hidden = false
                })
                
                }
        })
        downloadTask.resume()
        
    }
    
    @IBAction func refresh() {
        
        getWeatherData()
        refreshButton.hidden = true
        refreshIndicator.hidden = false
        refreshIndicator.startAnimating()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}





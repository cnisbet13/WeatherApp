//
//  Current.swift
//  Sunny Days
//
//  Created by Calvin Nisbet on 2015-06-12.
//  Copyright (c) 2015 Calvin Nisbet. All rights reserved.
//

import Foundation
import UIKit

struct Current {
    
    var currentTime: String?
    var temperature: Int
    var humidity: Double
    var precipProbability: Double
    var summary: String
    var icon: UIImage?
    
    init(weatherDictionary: NSDictionary) {
        
        let newWeatherDictionary: NSDictionary = weatherDictionary["currently"] as! NSDictionary
        
        
        temperature = newWeatherDictionary["temperature"] as! Int
        humidity = newWeatherDictionary["humidity"] as! Double
        precipProbability = newWeatherDictionary ["precipProbability"] as! Double
        summary = newWeatherDictionary ["summary"] as! String
     
        
        let iconString = newWeatherDictionary["icon"] as! String
        icon = weatherIcon(iconString)
        
        let currentTimeIntValue = newWeatherDictionary["time"] as! Int
        currentTime = dateStringFromUnixtime(currentTimeIntValue)
        
    }

    func dateStringFromUnixtime(unixTime: Int) -> String {
        let timeInSeconds = NSTimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        return dateFormatter.stringFromDate(weatherDate)
    }
    
    
    func weatherIcon(stringIcon: String) -> UIImage {
     
        var imageName: String
        
        switch stringIcon{
            case "clear-day":
            imageName = "clear-day"
            
        case "clear-night":
            imageName = "clear-night"
            
        case "rain":
            imageName = "rain"
            
        case "snow":
            imageName = "snow"
            
        case "sleet":
            imageName = "sleet"
            
        case "wind":
            imageName = "wind"
            
        case "fog":
            imageName = "fog"
            
        case "cloudy":
            imageName = "cloudy"
            
        case "partly-cloudy-day":
            imageName = "partly-cloudy"
            
        case "partly-cloudy-night":
            imageName = "cloudy-night"
            
        default: imageName = "default"
        }
        var iconImage = UIImage(named: imageName)
        return iconImage!
    }
    
}
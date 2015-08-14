//
//  WeeklyTableViewController.swift
//  Sunny Days
//
//  Created by Calvin Nisbet on 2015-07-07.
//  Copyright (c) 2015 Calvin Nisbet. All rights reserved.


import UIKit

class WeeklyTableViewController: UITableViewController {
    
    @IBOutlet weak var currentTemperatureLabel: UILabel?
    @IBOutlet weak var currentWeatherIcon: UIImageView?
    @IBOutlet weak var currentPrecipitationLabel: UILabel?
    @IBOutlet weak var currentTemperatureRangeLabel: UILabel?
    
    // Location coordinates
    let coordinate: (lat: Double, lon: Double) = (37.8267,-122.423)
    
    // TODO: Enter your API key here
  
    private let forecastAPIKey = "beb199041f9a378c0e52ba94bd6ec194"
    
    var weeklyWeather: [DailyWeather] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        retrieveWeatherForecast()
        
    }
    
    func configureView() {
        // Set table view's background view property
        tableView.backgroundView = Background()
        
        //Setting our custom height for the tableviewcells
        tableView.rowHeight = 64
        
    
        
        // Change the font and size of nav bar text
        if let navBarFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0) {
            let navBarAttributesDictionary: [NSObject: AnyObject]? = [
                NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSFontAttributeName: navBarFont
            ]
            navigationController?.navigationBar.titleTextAttributes = navBarAttributesDictionary
        }
    //Refresh Control
    refreshControl?.layer.zPosition = tableView.backgroundView!.layer.zPosition + 1
    }
    
    
    @IBAction func refreshed() {
        retrieveWeatherForecast()
        refreshControl?.endRefreshing()
    }
    
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showToday" {
            if let indexPath = tableView.indexPathForSelectedRow() {
                let dailyWeather = weeklyWeather[indexPath.row]
                
                (segue.destinationViewController as! ViewController).dailyWeather = dailyWeather
            }
        }
    }
    
    
    // MARK: - Table view data source
     
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Weekly Forecast"
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return weeklyWeather.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell") as! DailyTableViewCell
        
        let dailyWeather = weeklyWeather[indexPath.row]
        
        if let maxTemp = dailyWeather.maxTemperature {
            cell.TempLabel.text = "\(maxTemp)º"
        }
        cell.dayLabel.text = dailyWeather.day
        cell.weatherIcon.image = dailyWeather.icon
        
        return cell
    }
    
    
    
    //mark: - delegate methods
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 170/255.0, green: 131/255.0, blue: 244/255.0, alpha: 1.0)
        
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 14.0)
            header.textLabel.textColor = UIColor.whiteColor()
        }
    }
    
    
    
    
    // MARK: - Weather Fetching
    
    
    
    
    
    func retrieveWeatherForecast() {
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(coordinate.lat, lon: coordinate.lon) {
            (let forecast) in
            if let weatherForecast = forecast,
                let currentWeather = weatherForecast.currentWeather {
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if let temperature = currentWeather.temperature {
                        self.currentTemperatureLabel?.text = "\(temperature)"
                    }
                    if let precipitation = currentWeather.precipProbability {
                        self.currentPrecipitationLabel?.text = "Rain: \(precipitation)%"
                    }
                    if let icon = currentWeather.icon {
                        self.currentWeatherIcon?.image = icon
                    }
                    self.weeklyWeather = weatherForecast.weekly
                    if let highTemperature = self.weeklyWeather.first?.maxTemperature,
                    let lowTemperature = self.weeklyWeather.first?.minTemperature {
                        self.currentTemperatureRangeLabel?.text = "↑\(highTemperature)º↓\(lowTemperature)º"
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
}
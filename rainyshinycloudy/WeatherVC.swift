//
//  WeatherVC.swift
//  rainyshinycloudy
//
//  Created by Tyler Shelton on 2017-05-03.
//  Copyright © 2017 Bullfrog Development Studio. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    static var celsiusFahrenheitSelection = true
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var highLowCurrentDayTempLabel: UILabel!
    @IBOutlet weak var celsiusButtonLabel: UIButton!
    @IBOutlet weak var fahrenheitButtonLabel: UIButton!
    
    @IBAction func fahrenheitButtonPressed(_ sender: Any) {
        celsiusButtonLabel.setTitleColor(.darkGray, for: .normal)
        fahrenheitButtonLabel.setTitleColor(.white, for: .normal)
        WeatherVC.celsiusFahrenheitSelection = false
        updateMainUI()
        self.tableView.reloadData()
      
    }
    
    @IBAction func celsiusButtonPressed(_ sender: Any) {
        celsiusButtonLabel.setTitleColor(.white, for: .normal)
        fahrenheitButtonLabel.setTitleColor(.darkGray, for: .normal)
        WeatherVC.celsiusFahrenheitSelection = true
        updateMainUI()
        self.tableView.reloadData()
    }
    

    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateMainUI()
                }
                
            }

            
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        
        let forecastURL = URL(string: FORECAST_URL)!
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                
                    for index in 0..<8/*list*/ {
                        let forecast = Forecast(weatherDict: list[index])
                        self.forecasts.append(forecast)
                    }
                    self.forecasts.remove(at:0)
                    self.tableView.reloadData()
                    
                }
            }
            completed()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }

    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTempCel)°"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: "\(currentWeather.weatherCode)")
        if WeatherVC.celsiusFahrenheitSelection == true {
            currentTempLabel.text = "\(currentWeather.currentTempCel)°C"
//            highLowCurrentDayTempLabel.text = currentWeather.highLowTempCel
            highLowCurrentDayTempLabel.text = currentWeather._curFeelsLikeCel
        } else {
            currentTempLabel.text = "\(currentWeather.currentTempFah)°F"
//            highLowCurrentDayTempLabel.text = currentWeather.highLowTempFah
            highLowCurrentDayTempLabel.text = currentWeather._curFeelsLikeFah
        }
        
    }

}


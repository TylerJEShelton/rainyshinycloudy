//
//  CurrentWeather.swift
//  rainyshinycloudy
//
//  Created by Tyler Shelton on 2017-05-04.
//  Copyright © 2017 Bullfrog Development Studio. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _weatherDesc: String!
    var _currentTempCel: Int!
    var _highTempCel: Int!
    var _lowTempCel: Int!
    var _highLowTempCel: String!
    
    var _currentTempFah: Int!
    var _highTempFah: Int!
    var _lowTempFah: Int!
    var _highLowTempFah: String!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var weatherDesc: String {
        if _weatherDesc == nil {
            _weatherDesc = ""
        }
        return _weatherDesc
    }
    
    var currentTempCel: Int {
        if _currentTempCel == nil {
            _currentTempCel = 0
        }
        return _currentTempCel
    }
    
    var currentTempFah: Int {
        if _currentTempFah == nil {
            _currentTempFah = 0
        }
        return _currentTempFah
    }

    var highTempCel: Int {
        if _highTempCel == nil {
            _highTempCel = 0
        }
        return _highTempCel
    }
    
    var lowTempCel: Int {
        if _lowTempCel == nil {
            _lowTempCel = 0
        }
        return _lowTempCel
    }
    
    var highLowTempCel: String {
        if _highLowTempCel == nil {
            _highLowTempCel = ""
        }
        
        self._highLowTempCel = "High: \(highTempCel)°C   Low: \(lowTempCel)°C"
        return _highLowTempCel
    }
    
    var highTempFah: Int {
        if _highTempFah == nil {
            _highTempFah = 0
        }
        return _highTempFah
    }
    
    var lowTempFah: Int {
        if _lowTempFah == nil {
            _lowTempFah = 0
        }
        return _lowTempFah
    }
    
    var highLowTempFah: String {
        if _highLowTempFah == nil {
            _highLowTempFah = ""
        }
        
        self._highLowTempFah = "High: \(highTempFah)°F   Low: \(lowTempFah)°F"
        return _highLowTempFah
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        //let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                    }
                    if let desc = weather[0]["description"] as? String {
                        self._weatherDesc = desc.capitalized
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    if let currentTemperature = main["temp"] as? Double {
                        
                        self._currentTempCel = lround(currentTemperature - 273.15)
                        self._currentTempFah = lround(currentTemperature * (9/5) - 459.67)

                    }
                    
                    if let highTemperature = main["temp_max"] as? Double {
                        
                        
                            self._highTempCel = lround(highTemperature - 273.15)
                            self._highTempFah = lround(highTemperature * (9/5) - 459.67)
                    }

                    if let lowTemperature = main["temp_min"] as? Double {
                        
                            self._lowTempCel = lround(lowTemperature - 273.15)
                            self._lowTempFah = lround(lowTemperature * (9/5) - 459.67)
                
                    }

                }
                
            }
            completed()
        }
        
        
    }
}

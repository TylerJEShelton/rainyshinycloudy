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
    var _weatherCode: Int!
    var _currentTempCel: Double!
    var _curFeelsLikeCel: String!
//    var _highTempCel: Double!
//    var _lowTempCel: Double!
//    var _highLowTempCel: String!
//    
    var _currentTempFah: Double!
    var _curFeelsLikeFah: String!
//    var _highTempFah: Double!
//    var _lowTempFah: Double!
//    var _highLowTempFah: String!
//    
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
    
    var weatherCode: Int {
        if _weatherCode == nil {
            _weatherCode = 0
        }
        return _weatherCode
    }
    
    var currentTempCel: Double {
        if _currentTempCel == nil {
            _currentTempCel = 0.0
        }
        return _currentTempCel
    }
    
    var currentTempFah: Double {
        if _currentTempFah == nil {
            _currentTempFah = 0.0
        }
        return _currentTempFah
    }
    
    var curFeelsLikeCel: String {
        if _curFeelsLikeCel == nil {
            _curFeelsLikeCel = ""
        }
        return _curFeelsLikeCel
    }
    
    var curFeelsLikeFah: String {
        if _curFeelsLikeFah == nil {
            _curFeelsLikeFah = ""
        }
        return _curFeelsLikeFah
    }

//    var highTempCel: Double {
//        if _highTempCel == nil {
//            _highTempCel = 0.0
//        }
//        return _highTempCel
//    }
//    
//    var lowTempCel: Double {
//        if _lowTempCel == nil {
//            _lowTempCel = 0.0
//        }
//        return _lowTempCel
//    }
//    
//    var highLowTempCel: String {
//        if _highLowTempCel == nil {
//            _highLowTempCel = ""
//        }
//        
//        self._highLowTempCel = "High: \(highTempCel)°C   Low: \(lowTempCel)°C"
//        return _highLowTempCel
//    }
//    
//    var highTempFah: Double {
//        if _highTempFah == nil {
//            _highTempFah = 0.0
//        }
//        return _highTempFah
//    }
//    
//    var lowTempFah: Double {
//        if _lowTempFah == nil {
//            _lowTempFah = 0.0
//        }
//        return _lowTempFah
//    }
//    
//    var highLowTempFah: String {
//        if _highLowTempFah == nil {
//            _highLowTempFah = ""
//        }
//        
//        self._highLowTempFah = "High: \(highTempFah)°F   Low: \(lowTempFah)°F"
//        return _highLowTempFah
//    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        //let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)
        Alamofire.request(FORECAST_URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let location = dict["location"] as? Dictionary<String, AnyObject> {
                    
                    if let name = location["name"] as? String {
                        self._cityName = name.capitalized
                    }
                }
                
                if let current = dict["current"] as? Dictionary<String, AnyObject> {
                    
                    if let condition = current["condition"] as? Dictionary<String, AnyObject> {
                        
                        if let text = condition["text"] as? String {
                            self._weatherType = text.capitalized
                        }
                        if let code = condition["code"] as? Int {
                            self._weatherCode = code
                        }
                    }
                    
//                    if let desc = weather[0]["description"] as? String {
//                        self._weatherDesc = desc.capitalized
//                    }
                
                
//                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    if let currentTempC = current["temp_c"] as? Double {
                        
                        self._currentTempCel = currentTempC
                        
//                        self._currentTempCel = lround(currentTemperature - 273.15)
//                        self._currentTempFah = lround(currentTemperature * (9/5) - 459.67)

                    }
                    
                    if let currentTempF = current["temp_f"] as? Double {
                        
                        self._currentTempFah = currentTempF
                        
                    }
                    
                    if let currentFeelsLikeF = current["feelslike_f"] as? Double {
                        
                        self._curFeelsLikeFah = "Feels like: \(currentFeelsLikeF)°F"
                        
                    }
                    
                    if let currentFeelsLikeC = current["feelslike_c"] as? Double {
                        
                        self._curFeelsLikeCel = "Feels like: \(currentFeelsLikeC)°C"
                        
                    }
                    
//                    if let highTemperature = main["temp_max"] as? Double {
//                        
//                        
//                            self._highTempCel = lround(highTemperature - 273.15)
//                            self._highTempFah = lround(highTemperature * (9/5) - 459.67)
//                    }
//
//                    if let lowTemperature = main["temp_min"] as? Double {
//                        
//                            self._lowTempCel = lround(lowTemperature - 273.15)
//                            self._lowTempFah = lround(lowTemperature * (9/5) - 459.67)
//                
//                    }

                }

            }
            completed()
        }
        
        
    }
}

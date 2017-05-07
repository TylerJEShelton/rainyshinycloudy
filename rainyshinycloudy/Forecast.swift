//
//  Forecast.swift
//  rainyshinycloudy
//
//  Created by Tyler Shelton on 2017-05-04.
//  Copyright © 2017 Bullfrog Development Studio. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    var _date: String!
    var _weatherType: String!
    var _weatherDesc: String!
    var _highTempCel: String!
    var _lowTempCel: String!
    var _highTempFah: String!
    var _lowTempFah: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
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
    
    var highTempCel: String {
        if _highTempCel == nil {
            _highTempCel = ""
        }
        return _highTempCel
    }
    
    var lowTempCel: String {
        if _lowTempCel == nil {
            _lowTempCel = ""
        }
        return _lowTempCel
    }
    
    var highTempFah: String {
        if _highTempFah == nil {
            _highTempFah = ""
        }
        return _highTempFah
    }
    
    var lowTempFah: String {
        if _lowTempFah == nil {
            _lowTempFah = ""
        }
        return _lowTempFah
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            if let min = temp["min"] as? Double {
             
                self._lowTempFah = "\(lround(min * (9/5) - 459.67))"
                self._lowTempCel = "\(lround(min - 273.15))"
//                let kelvinToFahrenheit = round(min * (9/5) - 459.67)
//                let kelvinToCelsius = round(min - 273.15)
                
//                self._lowTempFah = "\(kelvinToFahrenheit)"
//                self._lowTempCel = "\(kelvinToCelsius)"
                
            }
            
            if let max = temp["max"] as? Double {
                
//                self._highTemp = "\(max)"
                
                self._highTempFah = "\(lround(max * (9/5) - 459.67))"
                self._highTempCel = "\(lround(max - 273.15))"
                
//                if WeatherVC.celsiusFahrenheitSelection == true {
//                    let kelvinToCelsius = round(max - 273.15)
//                    self._highTemp = "\(kelvinToCelsius)"
//                } else {
//                    let kelvinToFarenheit = round(max * (9/5) - 459.67)
//                    self._highTemp = "\(kelvinToFarenheit)"
//                }
//     /*           //let kelvinToFahrenheit = round(max * (9/5) - 459.67)
//                let kelvinToCelsius = round(max - 273.15)
//                
//                //self._highTemp = "\(kelvinToFahrenheit)"
//                self._highTemp = "\(kelvinToCelsius)"*/
            }
            
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main.capitalized
            }
            
            if let desc = weather[0]["description"] as? String {
                self._weatherDesc = desc.capitalized
            }

        }
        
        if let date = weatherDict["dt"] as? Double {
            
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
    }
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}

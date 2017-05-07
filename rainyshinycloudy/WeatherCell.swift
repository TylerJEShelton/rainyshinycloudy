//
//  WeatherCell.swift
//  rainyshinycloudy
//
//  Created by Tyler Shelton on 2017-05-04.
//  Copyright © 2017 Bullfrog Development Studio. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    func configureCell(forecast: Forecast) {
        if WeatherVC.celsiusFahrenheitSelection == true {
            lowTemp.text = "\(forecast.lowTempCel)°C"
            highTemp.text = "\(forecast.highTempCel)°C"
        } else {
            lowTemp.text = "\(forecast.lowTempFah)°F"
            highTemp.text = "\(forecast.highTempFah)°F"
        }
        
        weatherType.text = forecast.weatherDesc
        dayLabel.text = forecast.date
        weatherIcon.image = UIImage(named: forecast.weatherType)
    }
}

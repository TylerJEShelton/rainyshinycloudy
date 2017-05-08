//
//  Constants.swift
//  rainyshinycloudy
//
//  Created by Tyler Shelton on 2017-05-04.
//  Copyright © 2017 Bullfrog Development Studio. All rights reserved.
//

import Foundation

//let BASE_URL = "http://api.openweathermap.org/data/2.5/"
//let WEATHER = "weather?"
//let FORECAST = "forecast/daily?"
//let LATITUDE = "lat="
//let LONGITUDE = "&lon="
//let NUMBER_OF_DAYS = "&cnt=10"
//let APP_ID = "&appid="
//let API_KEY = "e5910f72fa4a16a0cfcc87200fb6e0a8"

let NEW_BASE_URL = "https://api.apixu.com/v1/forecast.json?key="
let NEW_API_KEY = "6c2ada236e2442f589c01153170505"
let NEW_DAYS = "&days=8"
let NEW_LOCATION = "&q="
let NEW_LAT_LON_SEP = ","
//let NEW_WEATHER = "weather?"
//let NEW_FORECAST = "forecast/daily?"
//let NEW_LATITUDE = "lat="
//let NEW_LONGITUDE = "&lon="
//let NEW_NUMBER_OF_DAYS = "&cnt=10"
//let NEW_APP_ID = "&appid="


typealias DownloadComplete = () -> ()

//let CURRENT_WEATHER_URL = "\(BASE_URL)\(WEATHER)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"
//let FORECAST_URL = "\(BASE_URL)\(FORECAST)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(NUMBER_OF_DAYS)\(APP_ID)\(API_KEY)"

let FORECAST_URL = "\(NEW_BASE_URL)\(NEW_API_KEY)\(NEW_DAYS)\(NEW_LOCATION)\(Location.sharedInstance.latitude!)\(NEW_LAT_LON_SEP)\(Location.sharedInstance.longitude!)"


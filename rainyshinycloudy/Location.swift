//
//  Location.swift
//  rainyshinycloudy
//
//  Created by Tyler Shelton on 2017-05-04.
//  Copyright © 2017 Bullfrog Development Studio. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}

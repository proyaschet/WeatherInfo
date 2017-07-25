//
//  Weather+CoreDataProperties.swift
//  WeatherInfo
//
//  Created by Amarnath Manipatra on 25/07/17.
//  Copyright © 2017 otd. All rights reserved.
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var cityName: String?
    @NSManaged public var windSpeed: Double
    @NSManaged public var windDegree: Double
    @NSManaged public var temperature: Double
    @NSManaged public var pressure: Double
    @NSManaged public var humidity: Double
    @NSManaged public var minimumTemperature: Double
    @NSManaged public var maximumTemperature: Double
    @NSManaged public var weatherToday: String?
    @NSManaged public var weatherDescription: String?
    @NSManaged public var countryCode: String?

}

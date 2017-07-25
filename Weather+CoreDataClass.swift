//
//  Weather+CoreDataClass.swift
//  WeatherInfo
//
//  Created by Amarnath Manipatra on 25/07/17.
//  Copyright © 2017 otd. All rights reserved.
//

import Foundation
import CoreData

@objc(Weather)
public class Weather: NSManagedObject {
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    init(name : String, countryCode : String , description : String , weatherToday : String , humidity: Double , maxTemp : Double , minTemp : Double , pressure : Double , temp : Double , degree : Double , speed : Double , context : NSManagedObjectContext )
    {
        let entity = NSEntityDescription.entity(forEntityName: "Weather", in: context)!
        super.init(entity: entity, insertInto: context)
        self.cityName = name
        self.countryCode = countryCode
        self.weatherDescription = description
        self.weatherToday = weatherToday
        self.humidity = humidity
        self.maximumTemperature = maxTemp
        self.minimumTemperature = minTemp
        self.pressure = pressure
        self.temperature = temp
        self.windDegree = degree
        self.windSpeed = speed
        
    }

}

//
//  Constants.swift
//  WeatherInfo
//
//  Created by Amarnath Manipatra on 23/07/17.
//  Copyright © 2017 otd. All rights reserved.
//

import Foundation


    struct openWeather
    {
        
        static let scheme = "http"
        static let host = "api.openweathermap.org"
        static let path = "/data/2.5/weather"
        static let queryCity = "q"
        static let queryAPI = "APPID"
        static let appID = "9625dc08ac24d297c991ffa94b880706"
        
    }
    
    struct WeatherData {
        
        static var City : String!
        static var CountryCode : String!
        static var WeatherToday : String!
        static var WeatherDescription : String!
        static var Humidity : Double!
        static var WindSpeed : Double!
        static var WindDeg : Double!
        static var Pressure : Double!
        static var Temperature : Double!
        static var MinimumTemp : Double!
        static var MaximumTemp : Double!
        
    }

  struct pickerConstants
  {
   
    static var temperature = "TEMPERATURE"
    static var MinimumTemp = "MINIMUM TEMPERATURE"
    static var MaximumTemp = "MAXIMUM TEMPERATURE"
    static var Humidity = "HUMIDITY"
    static var WindSpeed = "WINDSPEED"
    static var WindDeg = "WINDDEGREE"
    static var Pressure = "PRESSURE"
    
    
   }

struct Animation {
    struct Duration {
        static let medium = 0.5
    }
}

struct ErrorIs {
    static let request = "There was an error with your request: "
    static let statusCode = "Your request returned a status code other than 2xx!"
    static let inData = "No data was returned by the request!"
    static let serialization = "Could not serialize the data from JSON"
}

struct NetworkError {
    static let base = "There was an error in API"
    static let openWeather = "An error occured trying to retrieve data from API"
    static let status = "There was a status error"
    static let statusCompletion = "A status code error occured from  API"
    static let parsing = "There was an error while parsing"
    static let downloading = "An error occured downloading data from API"
}

    
    


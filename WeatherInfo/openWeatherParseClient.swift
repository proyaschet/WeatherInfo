//
//  openWeatherParseClient.swift
//  WeatherInfo
//
//  Created by Amarnath Manipatra on 23/07/17.
//  Copyright © 2017 otd. All rights reserved.
//

import Foundation
import CoreData
class openWeatherParseClient
{
    
    var session = URLSession.shared
    var weatherInfo : Weather!
     func sessionTaskGetMethod(parameters: [String:AnyObject], completionHandlerForGET: @escaping (_ result: [String:AnyObject]?, _ error: String?) -> Void) -> URLSessionDataTask
     {
        let request = NSMutableURLRequest(url: openWeatherURLBuilder(parameters, withPathExtension: nil))
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            func sendError(_ error: String) {
                print(error)
                completionHandlerForGET(nil, error)
            }
            guard (error == nil) else {
                sendError(ErrorIs.request + error!.localizedDescription)
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError(ErrorIs.statusCode)
                return
            }
            guard let data = data else {
                sendError(ErrorIs.inData)
                return
            }
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertedData: completionHandlerForGET)
            
        }
        task.resume()
        return task
    }
    
    
    
    private func openWeatherURLBuilder(_ parameters: [String:AnyObject], withPathExtension: String?) -> URL {
        var components = URLComponents()
        components.scheme = openWeather.scheme
        components.host = openWeather.host
        components.path = openWeather.path + (withPathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems?.append(queryItem)
        }
        return components.url!
    }
    
    func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertedData: (_ result: [String:AnyObject]?, _ error: String?) -> Void) {
        
        
        var parsedResult : [String : AnyObject]?
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:AnyObject]
        } catch {
            completionHandlerForConvertedData(nil, ErrorIs.serialization)
        }
        completionHandlerForConvertedData(parsedResult, nil)
    }

    func WeatherDataByCity(cityName : String, completionHandlerForWeatherDataByCity : @escaping (_ weatherInfo : Weather?,_ success : Bool , _ error : String) -> Void)
    {
         let parameters: [String:AnyObject]? = [openWeather.queryCity:cityName as AnyObject,openWeather.queryAPI:openWeather.appID as AnyObject]
        let _ = self.sessionTaskGetMethod(parameters: parameters!) { (results, error) in
            guard (error == nil) else {
                print(NetworkError.base)
                completionHandlerForWeatherDataByCity (nil,false, error!)
                return
            }
            
            guard let parsedOpenWeatherData = results else
            {
                print("parse error")
                return
            }
        
            guard let cityName = parsedOpenWeatherData["name"] as? String else {
                
                
                return completionHandlerForWeatherDataByCity(nil,false, "could not get name")
                
            }
            
            WeatherData.City = cityName
            
            
            guard let jsonWind = parsedOpenWeatherData["wind"] as? NSDictionary else {
                
                
                return completionHandlerForWeatherDataByCity(nil,false, "could not parse wind array")
                
            }
            
            
            
            guard let windSpeed = jsonWind["speed"] as? Double else {
                
                print("error in guard Statement while getting jsonWindSpeed ")
                return completionHandlerForWeatherDataByCity(nil,false, "")
                
            }
            
           WeatherData.WindSpeed = windSpeed
            
            let windDegree = jsonWind["deg"] as? Double
            
            WeatherData.WindDeg = windDegree
            
            guard let jsonMain = parsedOpenWeatherData["main"] as? NSDictionary else {
                
                print("error in guard Statement while getting Main Array Dictionary JSON")
                return completionHandlerForWeatherDataByCity(nil,false, "")
                
            }
            
            guard var temp = jsonMain["temp"] as? Double else {
                
                print("error in guard Statement while getting Main Temp")
                return completionHandlerForWeatherDataByCity(nil,false, "")
                
            }
            
            temp = temp/10
            
            
            
            WeatherData.Temperature = temp
         
            
            guard let pressure = jsonMain["pressure"] as? Double else {
                
                print("error in guard Statement while getting Main pressure")
                return completionHandlerForWeatherDataByCity(nil,false, "")
                
            }
            WeatherData.Pressure = pressure
            print(WeatherData.Pressure)
            guard let humidity = jsonMain["humidity"] as? Double else {
                
                print("error in guard Statement while getting Main Humidity")
                return completionHandlerForWeatherDataByCity(nil,false, "")
                
            }
           
            
            
            guard let minimumTemp = jsonMain["temp_min"] as? Double else {
                
                print("error in guard Statement while getting Main Max Temp")
                return completionHandlerForWeatherDataByCity(nil,false, "")
                
            }
            
            WeatherData.MinimumTemp = minimumTemp
            
            
            guard let maximumTemp = jsonMain["temp_max"] as? Double else {
                
                print("error in guard Statement while getting Main Min Temp")
                return completionHandlerForWeatherDataByCity(nil,false, "")
                
            }
            
            WeatherData.MaximumTemp = maximumTemp
            
            guard let jsonWeather = parsedOpenWeatherData["weather"] as? [[String : Any]] else {
                
                print("error in guard Statement while getting weather Array Dictionary JSON")
                return completionHandlerForWeatherDataByCity(nil,false, "")
                
            }
            
            var weatherToday : String!
            var weatherDescription : String!
            
            for data in jsonWeather  {
                
               
                
                
                guard let weatherTodayData = data["main"] as? String else {
                    
                    print("error in guard Statement while getting Main Min Temp")
                    return completionHandlerForWeatherDataByCity(nil,false, "")
                    
                }
                weatherToday = weatherTodayData
                
                
                guard let weatherDescriptionData = data["description"] as? String else {
                    
                    print("error in guard Statement while getting Main Min Temp")
                    return completionHandlerForWeatherDataByCity(nil,false, "")
                    
                }
                weatherDescription = weatherDescriptionData
                
                
                
            }
            
            
            WeatherData.WeatherToday = weatherToday
            WeatherData.WeatherDescription = weatherDescription

            guard let jsonSystem = parsedOpenWeatherData["sys"] as? NSDictionary else {
                
                print("error in guard Statement while getting System Array Dictionary JSON")
                return completionHandlerForWeatherDataByCity(nil,false, "")
                
            }
            
            guard let countryCode = jsonSystem["country"] as? String else {
                
                print("error in guard Statement while getting Main Array Dictionary JSON")
                return completionHandlerForWeatherDataByCity(nil,false, "")
                
            }
            WeatherData.CountryCode = countryCode
            self.weatherInfo = Weather(name: cityName, countryCode: countryCode, description: weatherDescription, weatherToday: weatherToday, humidity: humidity, maxTemp: maximumTemp, minTemp: minimumTemp, pressure: pressure, temp: temp, degree: windDegree!, speed: windSpeed, context: AppDelegate.stack.context)
            
            AppDelegate.stack.save()
            
                       return completionHandlerForWeatherDataByCity(self.weatherInfo,true, "")

            

        }
    }
    
    class func sharedInstance() -> openWeatherParseClient {
        struct Singleton {
            static var sharedInstance = openWeatherParseClient()
        }
        return Singleton.sharedInstance
    }
    
    
}


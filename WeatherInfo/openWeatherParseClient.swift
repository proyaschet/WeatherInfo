//
//  openWeatherParseClient.swift
//  WeatherInfo
//
//  Created by Amarnath Manipatra on 23/07/17.
//  Copyright © 2017 otd. All rights reserved.
//

import Foundation

class openWeatherParseClient
{
    
    var session = URLSession.shared
    
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

    func WeatherDataByCity(cityName : String, completionHandlerForWeatherDataByCity : @escaping (_ success : Bool , _ error : String) -> Void)
    {
         let parameters: [String:AnyObject]? = [openWeather.queryCity:cityName as AnyObject,openWeather.queryAPI:openWeather.appID as AnyObject]
        let _ = self.sessionTaskGetMethod(parameters: parameters!) { (results, error) in
            guard (error == nil) else {
                print(NetworkError.base)
                completionHandlerForWeatherDataByCity (false, error!)
                return
            }
            
            guard let parsedOpenWeatherData = results else
            {
                print("parse error")
                return
            }
        
            guard let jsonCityName = parsedOpenWeatherData["name"] as? String else {
                
                print("error in guard Statement while getting Name")
                return completionHandlerForWeatherDataByCity(false, "")
                
            }
            print(jsonCityName)
            WeatherData.City = jsonCityName
            
            
            guard let jsonWind = parsedOpenWeatherData["wind"] as? NSDictionary else {
                
                print("error in guard Statement while getting Wind  Array Dictionary JSON")
                return completionHandlerForWeatherDataByCity(false, "")
                
            }
            
            
            
            guard let jsonWindSpeed = jsonWind["speed"] as? Double else {
                
                print("error in guard Statement while getting jsonWindSpeed ")
                return completionHandlerForWeatherDataByCity(false, "")
                
            }
            
           WeatherData.WindSpeed = jsonWindSpeed
            
            let jsonWindDeg2 = jsonWind["deg"] as? Double
            print(jsonWindDeg2)
            WeatherData.WindDeg = jsonWindDeg2
            
            guard let jsonMain = parsedOpenWeatherData["main"] as? NSDictionary else {
                
                print("error in guard Statement while getting Main Array Dictionary JSON")
                return completionHandlerForWeatherDataByCity(false, "")
                
            }
            
            guard var jsonMainTemp = jsonMain["temp"] as? Double else {
                
                print("error in guard Statement while getting Main Temp")
                return completionHandlerForWeatherDataByCity(false, "")
                
            }
            
            jsonMainTemp = jsonMainTemp/10
            
            
            print(jsonMainTemp)
            WeatherData.Temperature = jsonMainTemp
         
            
            guard let jsonMainPressure = jsonMain["pressure"] as? Double else {
                
                print("error in guard Statement while getting Main pressure")
                return completionHandlerForWeatherDataByCity(false, "")
                
            }
            WeatherData.Pressure=jsonMainPressure
            print(WeatherData.Pressure)
            guard let jsonMainHumidity = jsonMain["humidity"] as? Double else {
                
                print("error in guard Statement while getting Main Humidity")
                return completionHandlerForWeatherDataByCity(false, "")
                
            }
           
            
            
            guard let jsonMainMinimumTemp = jsonMain["temp_min"] as? Double else {
                
                print("error in guard Statement while getting Main Max Temp")
                return completionHandlerForWeatherDataByCity(false, "")
                
            }
            
            WeatherData.MinimumTemp = jsonMainMinimumTemp
            
            
            guard let jsonMainMaximumTemp = jsonMain["temp_max"] as? Double else {
                
                print("error in guard Statement while getting Main Min Temp")
                return completionHandlerForWeatherDataByCity(false, "")
                
            }
            
            WeatherData.MaximumTemp = jsonMainMaximumTemp
            
            guard let jsonWeather = parsedOpenWeatherData["weather"] as? [[String : Any]] else {
                
                print("error in guard Statement while getting weather Array Dictionary JSON")
                return completionHandlerForWeatherDataByCity(false, "")
                
            }
            
            var weatherToday : String!
            var weatherDescription : String!
            
            for data in jsonWeather  {
                
               
                
                
                guard let weatherTodayData = data["main"] as? String else {
                    
                    print("error in guard Statement while getting Main Min Temp")
                    return completionHandlerForWeatherDataByCity(false, "")
                    
                }
                weatherToday = weatherTodayData
                
                
                guard let weatherDescriptionData = data["description"] as? String else {
                    
                    print("error in guard Statement while getting Main Min Temp")
                    return completionHandlerForWeatherDataByCity(false, "")
                    
                }
                weatherDescription = weatherDescriptionData
                
                
                
            }
            
            
            WeatherData.WeatherToday = weatherToday
            WeatherData.WeatherDescription = weatherDescription

            guard let jsonSystem = parsedOpenWeatherData["sys"] as? NSDictionary else {
                
                print("error in guard Statement while getting System Array Dictionary JSON")
                return completionHandlerForWeatherDataByCity(false, "")
                
            }
            
            guard let jsonCountryCode = jsonSystem["country"] as? String else {
                
                print("error in guard Statement while getting Main Array Dictionary JSON")
                return completionHandlerForWeatherDataByCity(false, "")
                
            }
            WeatherData.CountryCode = jsonCountryCode
            
                       return completionHandlerForWeatherDataByCity(true, "")

            

        }
    }
    
    class func sharedInstance() -> openWeatherParseClient {
        struct Singleton {
            static var sharedInstance = openWeatherParseClient()
        }
        return Singleton.sharedInstance
    }
    
    
}


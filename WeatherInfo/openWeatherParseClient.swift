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

    func weather(cityName : String, completionHandlerForWeatherDataByCity : @escaping (_ success : Bool , _ error : String) -> Void)
    {
         let parameters: [String:AnyObject]? = [openWeather.queryCity:cityName as AnyObject,openWeather.queryAPI:openWeather.appID as AnyObject]
        let _ = self.sessionTaskGetMethod(parameters: parameters!) { (results, error) in
            guard (error == nil) else {
                print(NetworkError.base)
                completionHandlerForWeatherDataByCity (false, error!)
                return
            }
            
            
            guard let jsonCityName = results?["name"] as? String else {
                
                print("error in guard Statement while getting Name")
                return completionHandlerForWeatherDataByCity(false, "")
                
            }
            print(jsonCityName)
            completionHandlerForWeatherDataByCity(true, "")

        }
    }
    
    class func sharedInstance() -> openWeatherParseClient {
        struct Singleton {
            static var sharedInstance = openWeatherParseClient()
        }
        return Singleton.sharedInstance
    }
    
    
}


//
//  WeatherDetailViewController.swift
//  WeatherInfo
//
//  Created by Amarnath Manipatra on 25/07/17.
//  Copyright © 2017 otd. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var temperature: UILabel!
   @IBOutlet weak var today: UILabel!
    @IBOutlet weak var degree: UILabel!
    @IBOutlet weak var weatherDesc: UILabel!

    @IBOutlet weak var speed: UILabel!
    
    var weatherData : Weather!

    override func viewDidLoad() {
        super.viewDidLoad()
       title = "\(weatherData.cityName!) WeatherInfo"
        loadFromCoreData(data: weatherData)
       
    }


}

extension WeatherDetailViewController
{
    func loadFromCoreData(data : Weather)
    {
      
        
        code.text = data.countryCode
        humidity.text = "\(data.humidity)"
        pressure.text = "\(data.pressure)"
        temperature.text = "\(data.temperature)"
        today.text = data.weatherToday
        degree.text="\(data.windDegree)"
        weatherDesc.text = data.weatherDescription
        
        
    }
}

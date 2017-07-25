//
//  WeatherSearchViewController.swift
//  WeatherInfo
//
//  Created by Amarnath Manipatra on 23/07/17.
//  Copyright © 2017 otd. All rights reserved.
//

import UIKit

class WeatherSearchViewController: UIViewController {

    @IBOutlet weak var cityName: UITextField!
    @IBOutlet weak var resultDisplay: UILabel!
    @IBOutlet weak var valuePicker: UIPickerView!
    
    
    var pickerData :[String] = [pickerConstants.temperature,pickerConstants.WindSpeed,pickerConstants.WindDeg,pickerConstants.Pressure,pickerConstants.Humidity,pickerConstants.MaximumTemp,pickerConstants.MinimumTemp]
    var selectedValue = pickerConstants.temperature
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButton(_ sender: Any) {
         let cityNameInput = cityName.text!
        if(cityNameInput.isEmpty)
        {
            print("enter text")
        }
     let task = openWeatherParseClient.sharedInstance().WeatherDataByCity(cityName: cityNameInput) { (success, error) in
        print(success)
        
        }
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WeatherSearchViewController: UIPickerViewDataSource,UIPickerViewDelegate
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValue=pickerData[row]
    }
}

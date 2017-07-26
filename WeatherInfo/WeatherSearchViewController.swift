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
    @IBOutlet weak var detailInfo: UIBarButtonItem!
    
    
    var pickerData :[String] = [pickerConstants.temperature,pickerConstants.WindSpeed,pickerConstants.WindDeg,pickerConstants.Pressure,pickerConstants.Humidity,pickerConstants.MaximumTemp,pickerConstants.MinimumTemp]
    var selectedValue = pickerConstants.temperature
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
          hideKeyboardWhenTappedAround()
        cityName.delegate = self
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
            showAlert(title: "Input Error", message: "No city name found")
            return
        }
        showActivityIndicator()
        detailInfo.isEnabled = false
     _ = openWeatherParseClient.sharedInstance().WeatherDataByCity(cityName: cityNameInput) { (weatherInfo,success, error) in
        self.showActivityIndicator()
        if(success == true)
        {
            
            self.hideActivityIndicator()
            self.selectedResult(weatherInfo: weatherInfo)
            
            self.detailInfo.isEnabled = true
 
        }
        else{
            self.hideActivityIndicator()
            self.detailInfo.isEnabled = true
            self.showAlert(title: "NetworkError", message: error)
        }
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

extension WeatherSearchViewController
{
    func selectedResult(weatherInfo : Weather?)
    {
        print(selectedValue)
        if(selectedValue == pickerConstants.temperature)
        {
            if let temp = weatherInfo?.temperature
            {
                resultDisplay.text = "\(selectedValue) in \(cityName.text!) is \(temp)"
            }
            else
            {
                resultDisplay.text = "\(selectedValue)NOT FOUND"
            }
        }
        else if(selectedValue == pickerConstants.WindSpeed)
        {
         if let speed = weatherInfo?.windSpeed
         {
            resultDisplay.text = "\(selectedValue) in \(cityName.text!) is \(speed)"
         }
            else
         {
            resultDisplay.text = "\(selectedValue) NOT FOUND"
            }
        }
        
        else if(selectedValue == pickerConstants.Humidity)
        {
            if let humid = weatherInfo?.humidity
            {
                resultDisplay.text = "\(selectedValue) in \(cityName.text!) is \(humid)"
            }
            else
            {
                resultDisplay.text = "\(selectedValue) NOT FOUND"
            }
        }
        
        else if(selectedValue == pickerConstants.MaximumTemp)
        {
            if let matemp = weatherInfo?.maximumTemperature
            {
                resultDisplay.text = "\(selectedValue) in \(cityName.text!) is \(matemp)"
            }
            else
            {
                resultDisplay.text = "\(selectedValue) NOT FOUND"
            }
        }
        else if(selectedValue == pickerConstants.MinimumTemp)
        {
            if let  mitemp = weatherInfo?.minimumTemperature
            {
                resultDisplay.text = "\(selectedValue) in \(cityName.text!) is \(mitemp)"
            }
            else
            {
                resultDisplay.text = "\(selectedValue) NOT FOUND"
            }
        }
        
        else if(selectedValue == pickerConstants.Pressure)
        {
            if let pressure = weatherInfo?.pressure
            {
                resultDisplay.text = "\(selectedValue) in \(cityName.text!) is \(pressure)"
            }
            else
            {
                resultDisplay.text = "\(selectedValue) NOT FOUND"
            }
        }
        
        else if(selectedValue == pickerConstants.WindDeg)
        {
            if let degree = weatherInfo?.windDegree
            {
                resultDisplay.text = "\(selectedValue) in \(cityName.text!) is \(degree)"
            }
            else
            {
                resultDisplay.text = "\(selectedValue) NOT FOUND"
            }
        }
        else
        {
            resultDisplay.text = "Error found"
        }
            }
}

extension WeatherSearchViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
}

extension WeatherSearchViewController
{
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(WeatherSearchViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
   
    
    func showAlert(title : String , message: String) {
        let alertDisplay = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let pressOK = UIAlertAction(title: "OK", style: .default){
            _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertDisplay.addAction(pressOK)
        present(alertDisplay, animated: true, completion: nil)
    }
}

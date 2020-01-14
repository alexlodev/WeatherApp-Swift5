//
//  WeatherViewController.swift
//  Weather App
//
//  Created by Alex Lo on 12/30/2019.
//  Copyright © 2019 Alex Lo. All rights reserved.
//

import UIKit
import CoreLocation

//MARK: - UIViewController

class WeatherViewController: UIViewController  {
    
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextFild: UITextField!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchTextFild.delegate = self
        
    }
    
    @IBAction func locationButton(_ sender: Any) {
        locationManager.requestLocation()
    }
    
}

//MARK: - UITextFielDelegate


extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchButton(_ sender: UIButton) {
        if searchTextFild.text == "" {
            alert(title: "Error 🙄", message: "Enter a city name")
        }
        searchTextFild.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextFild.endEditing(true)
        return true
    }
    
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text != "" {
            
            return true
            
        } else {
            alert(title: "Error 🙄", message: "Enter a city name")
            textField.placeholder = "Type something"
            
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextFild.text {
            weatherManager.fecthWheatherTextField(cityName: city)
        }
        
        searchTextFild.text = ""
    }
}

//MARK: - Receive the data and send it to the UI

extension WeatherViewController: WeatherManagerDelegate {
    
    func updateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        
        DispatchQueue.main.async {
            
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            self.countryName.text = weather.countryName
            self.descriptionLabel.text = weather.description.uppercased()
            self.minTemp.text = "\(weather.minTempString)ºC"
            self.maxTemp.text = "\(weather.maxTempString)ºC"
            self.humidity.text = "\(weather.humidityString)%"
            
        }
    }
    
    func failError(error: Error) {
        
        DispatchQueue.main.async {
            self.alert(title: "Error, city not found 😰", message: "Check the name 🤔")
        }
        
    }
}

//MARK: - Receive lat and lon, for the location

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager (_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            
            locationManager.stopUpdatingLocation()
            
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fecthWeatherLocation( latitude: lat, longitude: lon)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("location error:", error)
        
    }
}

//MARK: - Refactor Alert's

extension WeatherViewController {
    func alert(title: String, message: String) {
        let alert = UIAlertController (title: title, message: message, preferredStyle: .alert)
        
        alert.addAction (UIAlertAction (title: "Ok", style: .default, handler: nil ))
        self.present( alert, animated: true)

    }
}

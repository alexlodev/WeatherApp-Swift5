//
//  WeatherModel.swift
//  Weather App
//
//  Created by Alex Lo on 1/5/20.
//  Copyright © 2019 Alex Lo. All rights reserved.
//


import Foundation

//MARK: - Variables for send to UI
struct WeatherModel {
    
    let countryName:String
    let cityName: String
    let description: String
    let conditionId: Int
    let humidity: Float
    let temperature: Float
    let minTemp: Float
    let maxTemp: Float

    //MARK: - Parse Int into String
    
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    var minTempString: String {
        return String(format: "%.0f", minTemp)
    }
    var maxTempString: String {
        return String(format: "%.0f", maxTemp)
    }
    var humidityString: String {
        return String(format: "%.0f", humidity)
    }
    
    //MARK: - Set icon weather
    
    
    var conditionName: String{
        switch conditionId {
        case  200...232:
            return "cloud.bold"
        case  300...321:
            return "cloud.drizzle"
        case  500...531:
            return "cloud.rain"
        case  600...622:
            return "cloud.snow"
        case  701...781:
            return "cloud.fog"
        case  800:
            return "sun.max"
        case  801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}



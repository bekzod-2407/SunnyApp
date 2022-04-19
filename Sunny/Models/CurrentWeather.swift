//
//  CurrentWeather.swift
//  Sunny
//
//  Created by user on 14/04/22.
//  Copyright © 2022 Ivan Akulov. All rights reserved.
//

import Foundation
 // for update and return json files in our screen > controller
struct CurrentWeather {
    let cityName: String
    let temperature: Double
    let feelsLikeTemperature: Double
    let conditionCode: Int  //id
    
    var  temperatureString: String {
        return "\(temperature.rounded())"
        
    }
    var feelsLikeTemperatureString: String {
        return "\(feelsLikeTemperature.rounded())"

    }
    var  systemNameIconString:String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "cloud.sun.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
    
      // update property init property  with CurrentWeatherData (another file struct)
    init?(currentweatherData: CurrentWeatherData) {
        cityName = currentweatherData.name
        temperature = currentweatherData.main.temp
        feelsLikeTemperature = currentweatherData.main.feelsLike
        conditionCode = currentweatherData.weather.first!.id
    }
    
}

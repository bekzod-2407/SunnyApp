//
//  CurrentWeatherData.swift
//  Sunny
//
//  Created by user on 14/04/22.
//  Copyright © 2022 Ivan Akulov. All rights reserved.
//

import Foundation
     
struct CurrentWeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    //myVariable: api.data(object , arrays)
}

//Decodable -> decoder doljni rasparsit
struct Main:Decodable {
    let temp : Double
    let feelsLike: Double
    
//    The data couldn’t be read because it is missing.  -> use enum CodingKeys
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }    
}

struct Weather: Decodable {
    let id : Int
    let main: String
}


// current weather data

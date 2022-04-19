//
//  NetworkWeatherManager.swift
//  Sunny
//
//  Created by user on 14/04/22.
//  Copyright © 2022 Ivan Akulov. All rights reserved.
//

import Foundation
import CoreLocation

// delegete
//protocol NetworkWeatherManagerDelegate: class {
//    func updateInterface(_: NetworkWeatherManager , with currentWeather: CurrentWeather )
//    // func updateInterface(_: NetworkWeatherManager -> sam delegator)
//}

class NetworkWeatherManager {
    
    // creating clousere
    enum RequestType {
        case cityName(city: String)
        case Coordinate(latitude: CLLocationDegrees ,longitude: CLLocationDegrees )
    }
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        var urlString = ""
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)&units=metric"
        case .Coordinate(let latitude , let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&apikey=\(apiKey)&units=metric"
        }
        performRequest(withUrlString: urlString)
    }
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
//
    func performRequest(withUrlString urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data) {
                    self.onCompletion?(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    
    
    // we must parse json and return data (updating file Struct)
    func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        //    decode(we must parse  obj (struct Data), from: data)
        
        do {  // decoder must be with try try in do{}
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentweatherData: currentWeatherData) else {
                return nil
            }
            // if all ok -> currentWeather
            return currentWeather
        }catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
        // if not okk -> nil
        
    }
    
}




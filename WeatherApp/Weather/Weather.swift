//
//  File.swift
//  WeatherApp
//
//  Created by Ernestas Kazinevicius on 01/02/2019.
//  Copyright © 2019 Ernestas Kazinevicius. All rights reserved.
//

import Foundation

class Weather: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
    
    private enum CodingKeys: String, CodingKey {
        case location = "location"
        case current = "current"
        case forecast = "forecast"
    }
}

struct Location: Codable {
    let name: String
    let country : String
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case country = "country"
    }
}

struct Current: Codable{
    let temp_c: Int
    let condition: Condition
    let wind_kph: Decimal
    let humidity: Int
    let feelslike_c: Decimal
    let vis_km: Decimal
    
    private enum CodingKeys: String, CodingKey {
        case temp_c =  "temp_c"
        case condition = "condition"
        case wind_kph = "wind_kph"
        case humidity = "humidity"
        case feelslike_c = "feelslike_c"
        case vis_km = "vis_km"
    }
}

struct Condition: Codable {
    let text: String
    let icon : String
    
    private enum CodingKeys: String, CodingKey {
        case text = "text"
        case icon = "icon"
    }
}

struct Forecast: Codable {
    let forecastday: [Forecastday]
    
    /*private enum CodingKeys: String, CodingKey {
        case forecastday = "forecastday"
    }*/
}

struct Forecastday: Codable {
    let date: String
    let day: Days
    
    /*private enum CodingKeys: String, CodingKey {
        case date = "date"
        case day = "day"
    }*/
}

struct Days: Codable {
    let maxtemp_c: Decimal
    let mintemp_c: Decimal
    let maxwind_kph: Decimal
    let condition: Condition
    /*private enum CodingKeys: String, CodingKey {
        case maxtemp_c = "maxtemp_c"
        case mintemp_c = "mintemp_c"
        case maxwind_kph = "maxwindkph"
    }*/
}



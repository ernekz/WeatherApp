//
//  Endpoint.swift
//  WeatherApp
//
//  Created by Ernestas Kazinevicius on 01/02/2019.
//  Copyright © 2019 Ernestas Kazinevicius. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    var urlComponent: URLComponents {
        var component = URLComponents(string: baseUrl)
        component?.path = path
        component?.queryItems = queryItems
        
        return component!
        
    }
    var request: URLRequest {
        return URLRequest(url: urlComponent.url!)
    }
}

enum WeatherEndpoint: Endpoint {
    case sevenDayForecast(city: String)
    
    var baseUrl: String {
        return "http://api.apixu.com/"
    }
    var path: String {
        return "/v1/forecast.json/"
    }
    var queryItems: [URLQueryItem]{
        switch self {
        case .sevenDayForecast(let city):
            let queryItems = [URLQueryItem(name: "key", value: "06b6ca14de014907888180806191401"), URLQueryItem(name: "q", value: city), URLQueryItem(name: "days", value: "7")]
            return queryItems
        }
    }
}

//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Ernestas Kazinevicius on 01/02/2019.
//  Copyright © 2019 Ernestas Kazinevicius. All rights reserved.
//

import Foundation

class WeatherAPIClient: APIClient {
    var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func current(with endpoint: WeatherEndpoint, completion: @escaping(Either<Current, APIError>) -> Void) {
        let request = endpoint.request
        self.fetch(with: request) { (either: Either<Weather, APIError>) in
            switch either {
            case .value(let weather):
                let weather = weather.current
                completion(.value(weather))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    func location(with endpoint: WeatherEndpoint, completion: @escaping(Either<Location, APIError>) -> Void) {
        let request = endpoint.request
        self.fetch(with: request) { (either: Either<Weather, APIError>) in
            switch either {
            case .value(let weather):
                let weather = weather.location
                completion(.value(weather))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    func forecast(with endpoint: WeatherEndpoint, completion: @escaping(Either<Forecast, APIError>) -> Void) {
        let request = endpoint.request
        self.fetch(with: request) { (either: Either<Weather, APIError>) in
            switch either {
            case .value(let weather):
                let weather = weather.forecast
                completion(.value(weather))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}

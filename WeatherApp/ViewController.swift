//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ernestas Kazinevicius on 29/10/2018.
//  Copyright © 2018 Ernestas Kazinevicius. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionsLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cityField: UITextField!

    let weatherApi = WeatherAPIClient()
    let location = LocationManager()
    var exists: Bool = true
    override func viewDidLoad() {

        super.viewDidLoad()
        
    }
    
    private func setCurrentLocation() {
            guard let exposedLocation = self.location.exposedLocation else {
                print("*** Error in \(#function): exposedLocation is nil")
                return
            }
            self.location.getPlace(for: exposedLocation) { placemark in
            guard let placemark = placemark else { return }
            var output = "Our location is:"
            if let country = placemark.country {
                output = output + "\n\(country)"
            }
            if let state = placemark.administrativeArea {
                output = output + "\n\(state)"
            }
            if let town = placemark.locality {
                output = output + "\n\(town)"
            }
            print(output)
        }
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        setCurrentLocation()
        let weatherEndpoint = WeatherEndpoint.sevenDayForecast(city: cityField.text!)
        weatherApi.current(with: weatherEndpoint) { (either) in
            switch either {
            case .value(let current):
                DispatchQueue.main.async {
                    if self.exists{
                        self.temperatureLbl.isHidden = false
                        self.conditionsLbl.isHidden = false
                        self.imageView.isHidden = false
                        self.temperatureLbl.text = current.temp_c.description
                        self.conditionsLbl.text = current.condition.text.description
                        self.imageView.downloaded(from: "http:\(current.condition.icon.description)")
                        
                    } else {
                        self.temperatureLbl.isHidden = true
                        self.conditionsLbl.isHidden = true
                        self.imageView.isHidden = true
                        self.cityLabel.text = "No matching city found"
                        self.exists = true
                    }
                }
            case .error(let error):
                print(error)
            }
            
        }
        weatherApi.location(with: weatherEndpoint) { (either) in
            switch either {
            case .value(let current):
                DispatchQueue.main.async {
                    if self.exists{
                        self.cityLabel.text = current.name.description
                        
                    } else {
                        self.cityLabel.text = "No matching city found"
                        self.exists = true
                    }
                }
            case .error(let error):
                print(error)
            }
            
        }
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


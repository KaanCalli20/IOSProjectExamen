//
//  WeatherController.swift
//  IOSExamenProject
//
//  Created by Kaan Calli on 22/12/2020.
//


import UIKit
import CoreLocation

class WeatherController: UIViewController {
    
    @IBOutlet weak var warmteLabel: UILabel!
    
    
    @IBOutlet weak var stadNaamLabel: UILabel!
    
    var weatherManager = WeatherService()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        
    }
    @IBAction func locatieRefreschPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    
}

extension WeatherController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherService, weather: WeatherDataModel) {
        DispatchQueue.main.async {
            print(weather.temperatureString)
            self.warmteLabel.text = weather.temperatureString
            self.stadNaamLabel.text = weather.adviesString
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension WeatherController: CLLocationManagerDelegate {
    
 
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

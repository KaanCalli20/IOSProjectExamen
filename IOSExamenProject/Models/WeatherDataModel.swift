//
//  WeatherDataModel.swift
//  IOSExamenProject
//
//  Created by Kaan Calli on 22/12/2020.
//

import Foundation

struct WeatherDataModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "Het is %.1f °C in %@", temperature,cityName)
    }
    
    var adviesString: String {
     
        var advies: String = ""
        
        switch self.temperature {
        case _ where temperature >= 18.00:
            advies = "Het is lekkerdag om te gaan shoppen."
        case _ where temperature >= 10.00:
             advies = "Het voelt nu wat een beetje frisjes."
        default:
            advies = "Ik zou wat dikker kleden als ik u was want het is ijskoud."
        }
        return advies
        
    }
}

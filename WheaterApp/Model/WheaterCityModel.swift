//
//  WheaterCityModel.swift
//  WheaterApp
//
//  Created by Andrés Flórez on 28/12/21.
//

import Foundation

struct WheaterCityModel {
    let main: String
    let description:String
    let icon:URL?
    let temp: String
    let name: String
    let country:String
    let lon:Double
    let lat:Double
    static let empty:WheaterCityModel = .init(main: "no wheater", description: "no description", icon: nil, temp: "0°", name: "No city", country: "No country", lon: 0.0,lat: 0.0)
    
    
}

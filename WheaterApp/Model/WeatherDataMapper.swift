//
//  WeatherDataMapper.swift
//  WheaterApp
//
//  Created by Andrés Flórez on 28/12/21.
//

import Foundation

struct WheaterDataMapper {
    func mapDataToModel(dataModel: WheaterModel) -> WheaterCityModel {
        guard let weather = dataModel.weather.first else {
            return .empty
        }
        
        return WheaterCityModel(main: weather.main, description: weather.weatherDescription , icon: URL(string: "https://openweathermap.org/img/wn/\(weather.icon)@2x.png"),temp: "\(Int(dataModel.main.temp))°", name: dataModel.name,country: dataModel.sys.country)
    }
}
    

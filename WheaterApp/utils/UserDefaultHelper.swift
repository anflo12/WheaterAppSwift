//
//  UserDefaultHelper.swift
//  WheaterApp
//
//  Created by Andrés Flórez on 11/01/22.
//

import Foundation

class UserDefaultHelper {
    private let wheaterModelMaper:WheaterDataMapper = WheaterDataMapper()

    func encoderData (data:Any, key:String){
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func decoderData (key:String) ->  WheaterCityModel {
        var tempWheater:WheaterCityModel? = .empty
        if let citiesData = UserDefaults.standard.array(forKey: "cities"){
           let  jsonData = try! JSONSerialization.data(withJSONObject: citiesData)

            let wheaterDataModel = try!  JSONDecoder().decode(WheaterModel.self, from: jsonData)
            //self.wheater.append(contentsOf: [ citiesData as [WheaterCityModel] ,wheaterData])
             tempWheater =  self.wheaterModelMaper.mapDataToModel(dataModel: wheaterDataModel )
        }
        return tempWheater!

    }
}

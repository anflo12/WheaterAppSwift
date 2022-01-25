//
//  UserDefaultHelper.swift
//  WheaterApp
//
//  Created by Andrés Flórez on 11/01/22.
//

import Foundation

class UserDefaultHelper {
    private let wheaterModelMaper:WheaterDataMapper = WheaterDataMapper()
    var citiesCoordsData:[[String:String]] = []

    func encoderData (data:WheaterCityModel){
        if UserDefaults.standard.array(forKey: "cities") != nil{
            
        
            citiesCoordsData.append(["\(data.name)": "\(data.lon),\(data.lat)"])

            
        }else{
            citiesCoordsData.append(["\(data.name)": "\(data.lon),\(data.lat)"])
        }
    print("encoded",citiesCoordsData)
        UserDefaults.standard.set(citiesCoordsData, forKey: "cities")
    }
    
    
    func decoderData () ->  [[String:String]] {
        var citiesCoords:[[String:String]] = []

        if let citiesData = UserDefaults.standard.array(forKey: "cities"){
            
            for citiesDatum in citiesData {
                citiesCoords.append(citiesDatum as! [String : String])
                
            }
            
            
        }
        // print(citiesCoords)
        return citiesCoords
    }
    
    func mapCoordsCity(coords:[String:String]) -> [Substring] {
        var coordsArray:[Substring] = []
        coords.forEach { (key: String, value: String) in
            let splitCoords = value.split(separator: ",")
            coordsArray = splitCoords
        }
        return coordsArray
    }
}

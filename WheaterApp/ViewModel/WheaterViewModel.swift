//
//  WheaterViewModel.swift
//  WheaterApp
//
//  Created by Andrés Flórez on 28/12/21.
//

import Foundation
import Combine
import SwiftUI
final class WheaterViewModel: ObservableObject {
    @Published var wheater :[WheaterCityModel] = [] 
    private let wheaterModelMaper:WheaterDataMapper = WheaterDataMapper()
    private let userDefaultHelper:UserDefaultHelper = UserDefaultHelper()
    @Published var showModal:Bool = false
    @Published var wheaterDays :[[Daily]] = []
    
    func addNewWheater (wheaterData:WheaterCityModel){
        
    
        self.wheater.append(wheaterData)
        
        userDefaultHelper.encoderData(data: wheaterData)
       
    }
    
    func getWheaterDays(lon:Double, lat:Double){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=hourly,minutely,current,alerts&lang=es&appid=efbbb86413bec6e6c8cab4eda7c81865")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let _ = error{
                print("error")
            }
            
           
            if let data = data,
               let responseHttp = response as? HTTPURLResponse,
                responseHttp.statusCode == 200 {
                do {
                    let wheaterDaysDataModel = try  JSONDecoder().decode(WheaterDaysModel.self, from: data)

                    DispatchQueue.main.async {
                        
                        self.wheaterDays.append(wheaterDaysDataModel.daily)
                    }
                   
                   
                } catch {
                    print("error",error)
                }
            }
                
        }.resume()
        
    }
    func getWheater(lon:Double, lat:Double){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=efbbb86413bec6e6c8cab4eda7c81865&lang=es&units=metric")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let _ = error{
                print("error")
            }
            
           
            if let data = data,
               let responseHttp = response as? HTTPURLResponse,
                responseHttp.statusCode == 200 {
                do {
                    
                    UserDefaults.standard.set(data,forKey:"cities")

                    let wheaterDataModel = try  JSONDecoder().decode(WheaterModel.self, from: data)
                    DispatchQueue.main.async {
                        let tempWheater =  self.wheaterModelMaper.mapDataToModel(dataModel: wheaterDataModel )
                        
                        print("ww",tempWheater)
                        self.wheater.append(tempWheater)
                        let citiesCoords = self.userDefaultHelper.decoderData()

                        if citiesCoords.count == 0 {
                            self.userDefaultHelper.encoderData(data: tempWheater )
                        }
                    }
                } catch {
                    print("error",error)
                }
            }
                
        }.resume()
    }
}


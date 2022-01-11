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
    
    
    func addNewWheater (wheaterData:WheaterCityModel){
        let citiesData = userDefaultHelper.decoderData(key: "cities")
        
        self.wheater.append(contentsOf: [wheaterData,citiesData])
        
        
       
    }
    func getWheater(){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=cali&appid=efbbb86413bec6e6c8cab4eda7c81865&lang=es&units=metric")
        
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
                        self.wheater.append(tempWheater)
                    }
                } catch {
                    print("error",error)
                }
            }
                
        }.resume()
    }
}


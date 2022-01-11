//
//  SearchWheaterViewModel.swift
//  WheaterApp
//
//  Created by Andrés Flórez on 4/01/22.
//

import Foundation
import Combine

final class SearchWheaterViewModel: ObservableObject {
    

    private let wheaterModelMaper:WheaterDataMapper = WheaterDataMapper()
    @Published var searchWheater:WheaterCityModel = .empty
    func searchCity (query:String) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(query)&appid=efbbb86413bec6e6c8cab4eda7c81865&lang=es&units=metric")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let _ = error {
                print("error",error)
            }
         
            if let  responseHttp = response as? HTTPURLResponse,
               responseHttp.statusCode == 200 {
                if let data = data {
                    do {
                        let responseSearch = try JSONDecoder().decode(WheaterModel.self, from: data)
                        DispatchQueue.main.async {
                            self.searchWheater = self.wheaterModelMaper.mapDataToModel(dataModel: responseSearch)
                            
                        }
                    }catch {
                        
                    }
                } else{
                    self.searchWheater = .empty
                }
                
                
               
            }
        }.resume()
    }
    
    
}

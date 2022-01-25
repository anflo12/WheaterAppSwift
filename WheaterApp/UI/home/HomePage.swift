//
//  HomePage.swift
//  WheaterApp
//
//  Created by Andrés Flórez on 16/12/21.
//

import SwiftUI
import Foundation
struct HomePage: View {
    @EnvironmentObject var viewModel:WheaterViewModel 
    @StateObject var searchViewModel:SearchWheaterViewModel = SearchWheaterViewModel()
    private let userDefaultHelper:UserDefaultHelper = UserDefaultHelper()
    @ObservedObject private var location = LocationViewModel()
    @State private var text:String = ""
    @State private var isEditting:Bool = false
    @State private var showModal = false
    
    var body: some View {
         
        ZStack{
            
                LinearGradient(gradient: Gradient(colors:[CustomsColors.background,CustomsColors.background,Color.gray]), startPoint: .top, endPoint:.bottom)
                    .ignoresSafeArea()
                
                
                
                VStack{
                    HStack{
                        
                        Button(action:{
                            self.showModal = !showModal
                        } ) {
                            Image(systemName: "plus.square.fill")
                                .foregroundColor(CustomsColors.textColor)
                                .font(.system(size: 30))
                        }
                        
                        
                        Spacer()
                        
                        Button(action:{
                             
                        } ) {
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(CustomsColors.textColor)
                                .font(.system(size: 30))
                        }
                    }.padding(.horizontal)
                    
                    if viewModel.wheater.count != 0 {
                        TabView{
                            ForEach(viewModel.wheater.filter{city in return city.name != "No city"}, id: \.name) { wheater in
                                VStack{
                                    WheaterInfo(wheaterCity:wheater)
                                }.padding(.bottom,12)
                            }
                        }.tabViewStyle(.page)
                            .frame(height:450)
                    }
                    
                    
                    HStack{
                        Text("Next days weather")
                            .foregroundColor(CustomsColors.textColor)
                            .font(.title2)
                            .bold().padding()
                        Spacer()
                    }
                    
                    ScrollView(.horizontal){
                        let wheaterDaysList = viewModel.wheaterDays.count > 0 ? viewModel.wheaterDays[0] : []
                        
                        
                        LazyHStack {
                            ForEach( wheaterDaysList , id: \.dt) { wheaterDay in
                                WheaterItemList(wheaterDay:wheaterDay )
                            }
                        }
                    }.padding(.horizontal)
                    Spacer()
                } .fullScreenCover(isPresented: self.$showModal ) {
                    SearchModalPage(showModal:self.$showModal).environmentObject(searchViewModel)
                }
                
                
            
        }.onAppear {
            let citiesCoords = userDefaultHelper.decoderData()
            let _ = print("okii",location.coords)
            if location.coords.lon != 0.0 && location.coords.lat != 0.0 {
                if citiesCoords.count > 0 {
                    for coord in citiesCoords {
                        let coords = userDefaultHelper.mapCoordsCity(coords: coord)
                        let longitud = (coords[0] as NSString).doubleValue
                        let latitud = (coords[1] as NSString).doubleValue

                        viewModel.getWheater(lon:longitud, lat:latitud)
                        viewModel.getWheaterDays(lon:longitud, lat:latitud)
                    
                    }
                }else {
                    viewModel.getWheater(lon: location.coords.lon, lat:location.coords.lat)
                    viewModel.getWheaterDays(lon: location.coords.lon, lat:location.coords.lat)
                }
            }
            
        }
        
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
            .preferredColorScheme(.dark)
    }
}

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
    @State private var text:String = ""
    @State private var isEditting:Bool = false
    @State private var showModal = false
    var body: some View {
        let _ = print(viewModel.wheater)
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
                    LazyHStack {
                        ForEach(1...10, id: \.self) { count in
                            WheaterItemList()
                        }
                    }
                }.padding(.horizontal)
                Spacer()
            } .fullScreenCover(isPresented: self.$showModal ) {
                SearchModalPage(showModal:self.$showModal).environmentObject(searchViewModel)
            }
            
            
        }.onAppear {
            viewModel.getWheater()
        }
        
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
            .preferredColorScheme(.dark)
    }
}

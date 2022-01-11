//
//  SearchPage.swift
//  WheaterApp
//
//  Created by Andrés Flórez on 15/12/21.
//

import SwiftUI

struct SearchModalPage: View {
    @State private var text = ""
    @EnvironmentObject private var searchViewModel:SearchWheaterViewModel
    @StateObject private var viewModel:WheaterViewModel = WheaterViewModel()
    @Binding var  showModal:Bool
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors:[CustomsColors.background,CustomsColors.background,Color.gray]), startPoint: .top, endPoint:.bottom)
                .ignoresSafeArea()
            
            VStack{
                HStack{
                    Button(action:{
                        self.showModal.toggle()
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(CustomsColors.textColor)
                            .font(.system(size: 25))
                            .padding(.leading)
                    }
                    
                    SearchTextField( text:$text)
                    
                    
                }
                
                if   searchViewModel.searchWheater.main != "no wheater" {
                    WheaterInfoView(searchViewModel: _searchViewModel , showModal:$showModal)
                        
                    
                }
                
                
                
               
                
                
                
                
                Spacer()
            }.padding(.top,22)
            
            
            
        }
    }
}


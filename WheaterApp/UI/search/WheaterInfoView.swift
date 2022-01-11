//
//  WheaterInfoView.swift
//  WheaterApp
//
//  Created by Andrés Flórez on 6/01/22.
//

import SwiftUI

import Combine
struct WheaterInfoView: View {
    @EnvironmentObject  var searchViewModel:SearchWheaterViewModel
    @EnvironmentObject  private var viewModel:WheaterViewModel
    @Binding var showModal:Bool
    let textColor:Color = CustomsColors.textColor
    
    var body: some View {

      

            VStack{
                
               
                AsyncImage(url: searchViewModel.searchWheater.icon!) { image in
                    image
                        .resizable()
                    
                } placeholder: {
                    Color.purple.opacity(0.1)
                }
                .frame(width: 200, height: 200)
                
                
              
                Text("\(searchViewModel.searchWheater.name),\(searchViewModel.searchWheater.country)").foregroundColor(textColor).font(.system(size: 22))
                    .bold()
                    .padding(.bottom,5)
                
                Text("\(searchViewModel.searchWheater.description)").foregroundColor(textColor).font(.title2)
                Text("\(searchViewModel.searchWheater.temp)").font(.system(size: 75))
                    .foregroundColor(textColor)
                    .bold()
                    .frame( alignment: .center)
                
                
                Button(action: {
                    self.viewModel.addNewWheater(wheaterData: searchViewModel.searchWheater)
                    self.showModal.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 32))
                        .foregroundColor(CustomsColors.textColor)
                    Text("Agregar a inicio")
                        .font(.title2)
                        .foregroundColor( CustomsColors.textColor)
                }
                
                Spacer()

            }.padding(.top)
            .onDisappear {
                self.searchViewModel.searchWheater = .empty
            }
        
        
        
    }
    
}




//
//  SearchTextField.swift
//  WheaterApp
//
//  Created by Andrés Flórez on 4/01/22.
//

import Foundation

import SwiftUI
struct SearchTextField: View {
    @Binding  var text :String
    @State private var  isEditting = false
    @EnvironmentObject var searchViewModel:SearchWheaterViewModel

    var body: some View {
        TextField("Buscar cuidad ...", text: $text)
            .padding(10)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 10)
            .onTapGesture {
                isEditting = true
            }
        
        if isEditting{
            Button(action:{
                
                self.searchViewModel.searchCity(query: text)
                   
            }){
                Text("Buscar")
                    .foregroundColor(CustomsColors.textColor    )
            }.padding(.trailing)
            
            
        }
    }
}

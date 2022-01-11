//
//  WheaterInfo.swift
//  WheaterApp
//
//  Created by Andrés Flórez on 15/12/21.
//

import SwiftUI
import Combine
struct WheaterInfo: View {
     var wheaterCity:WheaterCityModel
    
    let textColor:Color = CustomsColors.textColor

    var body: some View {
            VStack{
                

                AsyncImage(url: wheaterCity.icon){image in
                    image
                        .resizable()
                        .frame(maxWidth: 200, maxHeight:200, alignment: .center)
                } placeholder: {
                    Color.purple.opacity(0.1)
                }
                Text("\(wheaterCity.name),\(wheaterCity.country)").foregroundColor(textColor).font(.system(size: 22))
                    .bold()
                    .padding(.bottom,5)
                
                Text("\(wheaterCity.description)").foregroundColor(textColor).font(.title2)
                Text("\(wheaterCity.temp)").font(.system(size: 75))
                    .foregroundColor(textColor)
                    .bold()
                    .frame( alignment: .center)
            }
            
           
        }
    
}



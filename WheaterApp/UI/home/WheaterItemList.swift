//
//  WheaterItemList.swift
//  WheaterApp
//
//  Created by Andrés Flórez on 15/12/21.
//

import SwiftUI

struct WheaterItemList: View {
    var wheaterDay:Daily
    
    var body: some View {
        let wheater = wheaterDay.weather.first
        
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(CustomsColors.backgroundCard)
                .shadow(radius: 10 )
            VStack{
                AsyncImage(url:URL(string: "https://openweathermap.org/img/wn/\(String(describing: wheater!.icon))@2x.png")){image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100, alignment: .center )
                } placeholder: {
                    Color.purple.opacity(0.1)
                }
                Text("\(wheater!.weatherDescription)").font(.subheadline)
                    .foregroundColor(CustomsColors.cardTextColor)
                    
                Text("\(Int(wheaterDay.temp.day/10))°").font(.title2)
                    .foregroundColor(CustomsColors.cardTextColor)
                    .bold()
            }.padding()
                
        }.frame(minWidth:0,maxWidth: 200,maxHeight: 200)
        
        
    }
}


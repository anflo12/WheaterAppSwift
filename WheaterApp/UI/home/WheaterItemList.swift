//
//  WheaterItemList.swift
//  WheaterApp
//
//  Created by Andrés Flórez on 15/12/21.
//

import SwiftUI

struct WheaterItemList: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(CustomsColors.backgroundCard)
                .shadow(radius: 10 )
            VStack{
                Image(systemName: "sun.max.fill")
                    .foregroundColor(CustomsColors.cardTextColor).font(.system(size: 65))
                
                Text("32°").font(.title2)
                    .foregroundColor(CustomsColors.cardTextColor)
                    .bold()
            }.padding()
                
        }.frame(minWidth:0,maxWidth: 230,maxHeight: 200)
        
        
    }
}

struct WheaterItemList_Previews: PreviewProvider {
    static var previews: some View {
        WheaterItemList()
            .preferredColorScheme(.light)
    }
}

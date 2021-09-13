//
//  CardView.swift
//  CardView
//
//  Created by Andre Martingo on 10.09.21.
//

import SwiftUI

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
    
}

struct CardView: View {
    let image: String
    let title: String
    let subtitle: String
    let price1: String
    let price2: String
    let price3: String
    let isLoading: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .padding(.all, 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)

                Text(subtitle)
                    .font(.callout)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(price1)
                    .foregroundColor(.white)
                    .redacted(reason: isLoading ? .placeholder : [])
                
                Text(price2)
                    .foregroundColor(.white)
                    .redacted(reason: isLoading ? .placeholder : [])
                
                Text(price3)
                    .foregroundColor(.white)
                    .redacted(reason: isLoading ? .placeholder : [])
            }
            .padding(.all, 30)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color(red: 32/255, green: 36/255, blue: 38/255))
        .modifier(CardModifier())
        .padding(.all, 10)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(image: "bitcoin",
                 title: "BTC",
                 subtitle: "Bitcoin",
                 price1: "€ 38,431.76",
                 price2: "$ 45,426.39",
                 price3: "£ 33352.50",
                 isLoading: false)
            .previewLayout(.sizeThatFits)
    }
}


//
//  HomeView.swift
//  HomeView
//
//  Created by Andre Martingo on 01.09.21.
//

import SwiftUI

struct HomeView: View {
    @StateObject
    var store: HomeStore
    
    var body: some View {
        CardView(image: store.state.image,
                 title: store.state.title,
                 subtitle: store.state.subtitle,
                 price1: store.state.price1,
                 price2: store.state.price2,
                 price3: store.state.price3,
                 isLoading: store.state.isLoading)
            .onAppear(perform: { store.send(action: .onAppear) })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(store: .init())
    }
}

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
        Text(store.state.price)
            .onAppear(perform: { store.send(action: .onAppear) })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(store: .init())
    }
}

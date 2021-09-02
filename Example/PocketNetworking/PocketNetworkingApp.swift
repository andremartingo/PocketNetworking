//
//  PocketNetworkingApp.swift
//  PocketNetworking
//
//  Created by Andre Martingo on 16.08.21.
//

import SwiftUI

@main
struct PocketNetworkingApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(store: .init())
        }
    }
}

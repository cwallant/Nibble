//
//  NibbleApp.swift
//  Nibble
//
//  Created by Charles Coppieters 't Wallant on 11/24/21.
//

import SwiftUI
import Firebase

@main

struct NibbleApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}

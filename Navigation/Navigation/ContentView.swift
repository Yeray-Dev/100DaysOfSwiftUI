//
//  ContentView.swift
//  Navigation
//
//  Created by Yeray Blanco de la Fuente on 30/08/2026.
//

import SwiftUI



struct ContentView: View {
    @State private var title = "SwiftUI"
    
    var body: some View {
        NavigationStack {
            Text("Hello, world!")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    ContentView()
}

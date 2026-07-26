//
//  ContentView.swift
//  View&Modifier
//
//  Created by Yeray Blanco de la Fuente on 23/07/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var useRedText = false

    var body: some View {
        Button("Hello World") {
            // flip the Boolean between true and false
            useRedText.toggle()
        }
        .foregroundStyle(useRedText ? .red : .blue)
    }
}

#Preview {
    ContentView()
}

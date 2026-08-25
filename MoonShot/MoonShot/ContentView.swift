//
//  ContentView.swift
//  MoonShot
//
//  Created by Yeray Blanco de la Fuente on 22/08/2026.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isGrid = true
    
    var body: some View {
        NavigationStack {
            Group {
                if isGrid{
                    GridView()
                } else {
                    ListView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation {
                            isGrid.toggle()
                        }
                    } label: {
                        Image(systemName: isGrid ? "list.bullet" : "square.grid.2x2")
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}

//
//  ContentView.swift
//  PRSGame
//
//  Created by Yeray Blanco de la Fuente on 26/07/2026.
//

import SwiftUI

struct ContentView: View {
    let option = ["Rock", "Paper", "Scissors"]
    
    @State private var userOption = 0
    @State private var sysOption = 0
    @State private var winner = false;
    @State private var showingResult = false
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.85, green: 0.90, blue: 0.93),
                    Color(red: 0.72, green: 0.82, blue: 0.80),
                    Color(red: 0.63, green: 0.72, blue: 0.75)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack {
                Spacer()
                Section("Elige Piedra, Papel o Tijera "){
                    Spacer()
                    Button {
                        userOption = 0
                        logicGame()
                        showingResult = true
                    } label: {
                        Image("rock")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                    }
                    Spacer(); Button {
                        userOption = 1
                        logicGame()
                        showingResult = true
                    } label: {
                        Image("paper")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                    }
                    Spacer(); Button {
                        userOption = 2
                        logicGame()
                        showingResult = true
                    } label: {
                        Image("scissors")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                    }
                    Spacer(); Spacer()
                }
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .alert(winner ? "Ganaste!" : "Perdiste", isPresented: $showingResult){
                    Button("Otra vez", action: rest)
                } message: {
                    Text(sysOption >= 0 ? "La maquina eligió \(option[sysOption])" : "")
                }
            }
        }
    }
    
    func rest(){
        userOption = 0
        sysOption = 0
        winner = false
    }
    func logicGame(){
        sysOption = Int.random(in: 0..<3)
        winner = (userOption == (sysOption + 1) % 3)
    }
}

#Preview {
    ContentView()
}

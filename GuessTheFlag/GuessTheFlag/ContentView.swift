//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Yeray Blanco de la Fuente on 20/07/2026.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -360, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0
    @State private var roundCounter = 0
    @State private var showingFinalScore = false
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 30){
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.white)
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button{
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .shadow(radius: 5)
                                .transition(.pivot)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(.regularMaterial)
                }
                .alert(scoreTitle, isPresented: $showingScore){
                    Button("Continue", action: askQuestion)
                } message: {
                    Text(scoreMessage)
                }
                .alert("Game over", isPresented: $showingFinalScore) {
                    Button("Restart", action: resetGame)
                } message: {
                    Text("Your final score was \(score)")
                }
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
                
            }
            .padding()
        }

    }

    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number:Int){
        if number == correctAnswer{
            
            scoreMessage = "Your score is \(score + 1)"
            score += 1
            askQuestion()
        } else{
            scoreTitle = "Wrong"
            scoreMessage = "That's the flag of \(countries[number])"
            showingScore = true
            score -= 1
         
        }
        
        roundCounter += 1
        
        if roundCounter == 8 {
            showingFinalScore = true
        }
    }
    
    func resetGame(){
        score = 0
        roundCounter = 0
        showingScore = false
        askQuestion()
    }
}

#Preview {
    ContentView()
    
}

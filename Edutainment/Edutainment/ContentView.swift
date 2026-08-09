//
//  ContentView.swift
//  Edutainment
//
//  Created by Yeray Blanco de la Fuente on 09/08/2026.
//

import SwiftUI

enum Dificult: Int, CaseIterable {
    case easy = 1
    case medium = 2
    case hard = 3
    
    var label: String{
        switch self {
        case .easy: return "Easy"
        case .medium: return "Medium"
        case .hard: return "Hard"
        }
    }
}

struct ContentView: View {
    @State private var showConfWin = false
    @State private var isStart = false
    @State private var levelTable = 1.0
    @State private var chooiceNumbQuestions = 5
    @State private var chooiceDificult = 1
    @State private var printDificult = "Easy"
    @State private var randomNumber = 0
    @State private var score = 0
    @State private var roundCount = 0
    @State private var answerArray: [Int] = []
    var nQuestion = [5, 10, 20]
    
    
    var body: some View {
        NavigationStack{
            VStack{
                if showConfWin {
                    Spacer()
                    VStack {
                        Text("Chooice the multiplication table: \(Int(levelTable))")
                        Slider(value: $levelTable, in: 1...10, step: 1)
                    }
                        .padding(50)
                    Spacer()
                    VStack {
                        Text("Chooice the number of question")
                        HStack {
                            ForEach(nQuestion, id:\.self) { i in
                                Button(action: {
                                    chooiceNumbQuestions = i
                                }) {
                                    Text("\(i)")
                                        .padding(20)
                                }
                            }
                        }
                    }
                    Spacer()
                    VStack {
                        Text("Chooice the difficult")
                        HStack {
                            ForEach (Dificult.allCases, id:\.self) { d in
                                Button(action: {
                                    chooiceDificult = d.rawValue
                                    printDificult = d.label
                                }) {
                                    Text("\(d.label)")
                                        .padding(20)
                                }
                            }
                        }
                    }
                    Spacer()
                    Spacer()
                }
                else if showConfWin == false {
                    if isStart{
                       
                        VStack {
                            Text("\(Int(levelTable)) X \(randomNumber)")
                        }
                        VStack {
                            ForEach (answerArray, id: \.self) { n in
                                Button(action: {
                                    if  checkAnswer(goodNumber: Int(levelTable) * randomNumber, sendNumber: n) {
                                        score += 1
                                        roundCount += 1
                                        if roundCount < chooiceNumbQuestions {
                                            randomNumber = generateRandomInt(Dificult: chooiceDificult)
                                            answerArray = generateAnswer(n1: Int(levelTable), n2: randomNumber)
                                        } // PONER DISPLAY CUANDO ACABE LAS RONDAS 
                                    }
                                }) { Text("\(n)")}
                            }
                        }
                    }
                    else if !isStart {
                        Button(action: {
                            isStart = true
                            randomNumber = generateRandomInt(Dificult: chooiceDificult)
                            answerArray = generateAnswer(n1: Int(levelTable), n2: randomNumber)
                        }) {
                            Text("START!!")
                        }
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .principal) {
                    HStack(){
                        Text("Table: \(Int(levelTable))")
                        Text("Questions: \(chooiceNumbQuestions)")
                        Text("Dificult: \(printDificult)")
                        Spacer()
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        showConfWin.toggle()
                        randomNumber = generateRandomInt(Dificult: chooiceDificult)
                    }) {
                        Image(systemName: "gearshape")
                            .font(.title2)
                            .foregroundStyle(.primary)
                    }
                }
            }
        }
    }
}

func generateRandomInt(Dificult: Int) -> Int {
    var randomNumber = 0
    
    if Dificult == 1 {
        randomNumber = Int.random(in: 1...10)
    } else if Dificult == 2 {
        randomNumber = Int.random(in: 1...20)
    } else if Dificult == 3 {
        randomNumber = Int.random(in: 1...100)
    }
                
    return randomNumber
}

func generateAnswer (n1: Int, n2: Int) -> [Int] {
    let result = n1 * n2
    var array: [Int] = []
    
    array.append(result)
    
    for _ in 1...3 {
        var newInt = Int.random(in: (result - 6)...(result + 6))
        while newInt == result || newInt < 0 {
            newInt = Int.random(in: (result - 6)...(result + 6))
        }
            
        array.append(newInt)
    }
    
    array.shuffle()
    
    return array
}

func checkAnswer (goodNumber : Int, sendNumber: Int) -> Bool {
    if goodNumber == sendNumber { return true }
    
    return false
}

#Preview {
    ContentView()
}


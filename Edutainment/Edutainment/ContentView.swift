//
//  ContentView.swift
//  Edutainment
//
//  Created by Yeray Blanco de la Fuente on 09/08/2026.
//

import SwiftUI

// Extensión que permite crear un Color directamente desde un código hexadecimal (ej: Color(hex: "EAF6FF"))
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = Double((rgbValue >> 16) & 0xFF) / 255.0
        let g = Double((rgbValue >> 8) & 0xFF) / 255.0
        let b = Double(rgbValue & 0xFF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}

// Paleta de colores de la app, pensada para una interfaz clara y amigable para niños
extension Color {
    static let appBackground = Color(hex: "EAF6FF")   // Fondo general de la app
    static let startButton = Color(hex: "34C759")     // Botón de START
    static let answerBase = Color(hex: "5B8DEF")      // Botones de respuesta, estado normal
    static let answerCorrect = Color(hex: "34C759")   // Botón de respuesta cuando acierta
    static let answerWrong = Color(hex: "FF6B6B")     // Botón de respuesta cuando falla
    static let textOnDark = Color.white               // Texto sobre fondos de color (botones)
    static let textPrimary = Color(hex: "2D2D2D")     // Texto principal sobre el fondo general
}

enum Dificult: Int, CaseIterable {
    case easy = 1
    case medium = 2
    case hard = 3
    
    var label: String{
        switch self {
        case .easy: return "Easy"
        case .medium: return "Med"
        case .hard: return "Hard"
        }
    }
}

struct GameTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.body, design: .rounded))
            .fontWeight(.bold)
            .foregroundStyle(Color.textPrimary)
            .padding(8)
    }
}

struct GameButtonStype: ButtonStyle {
    
    var backGroundColor: Color = .blue
    var fullWidth: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding()
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .frame(height: 60)
            .background(backGroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
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
    @State private var showResumen = false
    var nQuestion = [5, 10, 20]
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.appBackground.ignoresSafeArea()
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
                                    .buttonStyle(GameButtonStype(backGroundColor: Color.startButton))
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
                                    .buttonStyle(GameButtonStype(backGroundColor: Color.startButton))
                                }
                            }
                        }
                        Spacer()
                        Spacer()
                    }
                    else if showConfWin == false {
                        if isStart{
                            Spacer()
                            VStack {
                                Text("Operation : \(Int(levelTable)) x \(randomNumber)")
                                    .font(.system(size: 50))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                                    .frame(maxWidth: .infinity)
                            }
                            Spacer()
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                                ForEach (answerArray, id: \.self) { n in
                                    Button(action: {
                                        if  checkAnswer(goodNumber: Int(levelTable) * randomNumber, sendNumber: n) {
                                            score += 1
                                        }
                                        if roundCount == chooiceNumbQuestions - 1 {
                                            showResumen = true
                                        }
                                        randomNumber = generateRandomInt(Dificult: chooiceDificult)
                                        answerArray = generateAnswer(n1: Int(levelTable), n2: randomNumber)
                                        roundCount += 1
                                    }) { Text("\(n)")}
                                        .buttonStyle(GameButtonStype(backGroundColor: Color.answerBase, fullWidth: true))
                                        .frame(maxWidth: .infinity, maxHeight: 60)
                                }
                            }
                            .padding(.horizontal, 20)
                            Spacer()
                        }
                        else if !isStart {
                            Spacer()
                            Button(action: {
                                isStart = true
                                randomNumber = generateRandomInt(Dificult: chooiceDificult)
                                answerArray = generateAnswer(n1: Int(levelTable), n2: randomNumber)
                            }) {
                                Text("START!!")
                            }
                            .buttonStyle(GameButtonStype(backGroundColor: Color.startButton, fullWidth: false))
                            Spacer()
                            Spacer()
                        }
                    }
                }
                .modifier(GameTextStyle())
                .toolbar{
                    ToolbarItem(placement: .principal) {
                        HStack(){
                            Text("Table: \(Int(levelTable))")
                            Text("Questions: \(chooiceNumbQuestions)")
                            Text("Dificult: \(printDificult)")
                            Spacer()
                        }
                        .modifier(GameTextStyle())
                        .background(Color.gray)
                        .clipShape(Capsule())
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
                .sheet(isPresented: $showResumen, onDismiss:{
                    score = 0
                    roundCount = 0
                    isStart = false
                }) {
                    Text("Finised")
                    Text("Your score is: \(score)")
                    
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
        while newInt == result || newInt < 0 || array.contains(newInt) {
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


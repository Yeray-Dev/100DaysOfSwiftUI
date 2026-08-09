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
    @State private var levelTable = 1.0
    @State private var chooiceNumbQuestions = 5
    @State private var chooiceDificult = 1
    
    var nQuestion = [5, 10, 20]
  
    
    var body: some View {
        NavigationStack{
            VStack{
                if showConfWin {
                    VStack {
                        Text("Chooice the multiplication table: \(Int(levelTable))")
                        Slider(value: $levelTable, in: 1...10, step: 1)
                    }
                    VStack {
                        Text("Chooice the number of question")
                        HStack {
                            ForEach(nQuestion, id:\.self) { i in
                                Button(action: {
                                    chooiceNumbQuestions = i
                                }) {
                                    Text("\(i)")
                                }
                            }
                        }
                    }
                    VStack {
                        Text("Chooice the difficult")
                        HStack {
                            ForEach (Dificult.allCases, id:\.self) { d in
                                Button(action: {
                                    chooiceDificult = d.rawValue
                                }) {
                                    Text("\(d.label)")
                                }
                            }
                        }
                    }
                } else if showConfWin == false {
                    Text("Pratice's win")
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        showConfWin.toggle()
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

#Preview {
    ContentView()
}


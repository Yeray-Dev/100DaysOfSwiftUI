//
//  ContentView.swift
//  Converter
//
//  Created by Yeray Blanco de la Fuente on 19/07/2026.
//

import SwiftUI

struct ContentView: View {
    let units = ["Meter", "Kilometer", "Feet", "Yard", "Mils"]

    @State private var inputUnits = "Meter"
    @State private var outputUnits = "Feet"
    @State private var inputNumber = 1.0
    @FocusState private var inputNumberIsFocused: Bool
    var outputNumber: Double {
        var unitBase = 0.0
        
        switch inputUnits {
            case "Meter":
                unitBase = inputNumber
            case "Kilometer":
                unitBase = inputNumber * 1000
            case "Feet":
                unitBase = inputNumber * 3.28084
            case "Yard":
                unitBase = inputNumber * 1.09361
            case "Mils":
                unitBase = inputNumber * 0.000621371
            default:
                unitBase  = inputNumber
        }
        switch outputUnits {
            case "Meter":
                return unitBase
            case "Kilometer":
                return unitBase / 1000
            case "Feet":
              return unitBase / 3.28084
            case "Yard":
                return unitBase / 1.09361
            case "Mils":
                return unitBase / 0.000621371
            default:
                return unitBase
        }
    }
    
    var body: some View {
        NavigationStack(){
            Form{
                Section("Number to convert"){
                    TextField("Amount", value: $inputNumber, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputNumberIsFocused)
                }
                Section("Units"){
                    Picker("Input units", selection: $inputUnits){
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    Picker("Output Units", selection: $outputUnits){
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Output"){
                    Text(outputNumber, format: .number)
                }
            }
            .navigationTitle("Converter")
            .toolbar{
                if inputNumberIsFocused{
                    Button("Done"){
                        inputNumberIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

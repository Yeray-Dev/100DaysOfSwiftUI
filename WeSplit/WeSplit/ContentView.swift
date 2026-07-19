//
//  ContentView.swift
//  WeSplit
//
//  Created by Yeray Blanco de la Fuente on 16/07/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    let tipPercentages = [20, 15, 10, 5, 0]
    var totalPerPerson: Double {
        let peopleCout = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCout
        return amountPerPerson
    }
    @FocusState private var amountIsFocused: Bool
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                Section("How much tip doy you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Picker("Number of People", selection: $numberOfPeople){
                    ForEach(2..<100){
                        Text("\($0) people")
                    }
                }
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD" ))
                }
                .navigationTitle("WeSplit")
                .toolbar {
                    if amountIsFocused {
                        Button("Done"){
                            amountIsFocused = false
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

//
//  AddView.swift
//  iExpense
//
//  Created by Yeray Blanco de la Fuente on 16/08/2026.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    var expenses: Expenses
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type){
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format:.currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            Button("Save") {
                let item = ExpenseItem(name: name, type: type, amount: amount)
                expenses.item.append(item)
            }
            .navigationTitle("Add New Expense")
            
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}

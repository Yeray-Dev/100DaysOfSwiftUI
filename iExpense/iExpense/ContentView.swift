//
//  ContentView.swift
//  iExpense
//
//  Created by Yeray Blanco de la Fuente on 16/08/2026.
//

import SwiftUI
import Observation

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var item = [ExpenseItem]()
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    func removeItems(at offsets: IndexSet) {
        expenses.item.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationStack{
            List {
                ForEach (expenses.item) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense.toggle()
                }
            }
        }
        .sheet(isPresented: $showingAddExpense){
            AddView(expenses: expenses)
            
        }
    }
}




#Preview {
    ContentView()
}

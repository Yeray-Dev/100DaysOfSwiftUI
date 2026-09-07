//
//  ContentView.swift
//  Tracker
//
//  Created by Yeray Blanco de la Fuente on 06/09/2026.
//

import SwiftUI

struct Activity: Codable, Identifiable {
    var id = UUID()
    var name: String
    var description: String
}

@Observable
class ActivityStore {
    var items: [Activity] = []
    
    private var url = URL.documentsDirectory.appending(path: "activities.json")
    
    init(){
        items = load()
    }
    
    func load() -> [Activity] {
        guard let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([Activity].self, from: data)
        else { return [] }
        return decoded
    }
    
    func save() {
       // guard let data = try? JSONEncoder().encode(items) else { return }
        //try? data.write(to: url, options: [.atomic, .completeFileProtection])
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: url, options: [.atomic, .completeFileProtection])
            print("Guardado en \(url.path())")
        } catch {
            print("error: \(error)")
        }
    }
    
    func add(_ activity: Activity) {
        items.append(activity)
        save()
    }
    
    func delete(_ activity: Activity) {
        items.removeLast()
        save()
    }
}

struct ContentView: View {
    @State private var activities = ActivityStore()
    @State private var ShowingActivity = false
    @State private var ShowinAddActivity = false
    var body: some View {
        NavigationStack{
            Button("Activities"){
                ShowingActivity = true
            }
            Button("Add new activity"){
                ShowinAddActivity = true
            }
            .navigationTitle("Habbit tracker")
            .sheet(isPresented: $ShowingActivity, content: {ActivityView()})
            .sheet(isPresented: $ShowinAddActivity, content: {AddActivityView()})
            .toolbar {
                Button("entrar", systemImage: "plus"){
                   // Text("Go to tracker")
                }
            }
        }
    }
}

struct ActivityView: View {
    var body: some View {
        Text("View for choose Activities")
    }
}

struct AddActivityView: View {
    var body: some View {
        Text("View for ADD Activities")
    }
}

#Preview {
    ContentView()
}

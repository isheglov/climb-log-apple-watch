//
//  ContentView.swift
//  Climb Log Watch App
//
//  Created by Ilia Shcheglov on 26.01.25.
//

import SwiftUI

// Data model to represent a climb
struct Climb: Identifiable {
    let id = UUID()
    let date: Date
    let grade: String
    let color: String
}

struct ContentView: View {
    // MARK: - State Variables
    @State private var climbDate: Date = Date()
    
    // Define available grades
    private let grades = ["V0", "V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8"]
    @State private var selectedGrade: String = "V0"
    
    // Define available colors
    private let colors = ["Red", "Blue", "Green", "Yellow", "Black", "White"]
    @State private var selectedColor: String = "Red"
    
    // Array to store climb logs
    @State private var climbs: [Climb] = []
    
    var body: some View {
        NavigationView {
            List {
                // Section for the climb date
                Section(header: Text("Climb Log")) {
                    DatePicker("Date", selection: $climbDate, displayedComponents: .date)
                }
                
                // Section for the grade picker
                Section(header: Text("Grade")) {
                    Picker("Grade", selection: $selectedGrade) {
                        ForEach(grades, id: \.self) { grade in
                            Text(grade).tag(grade)
                        }
                    }
                    // A wheel or menu style is typical on watchOS
                    .pickerStyle(WheelPickerStyle())
                }
                
                // Section for the color picker
                Section(header: Text("Color")) {
                    Picker("Color", selection: $selectedColor) {
                        ForEach(colors, id: \.self) { color in
                            Text(color).tag(color)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                
                // Button to log the climb
                Section {
                    Button("Log Climb") {
                        let newClimb = Climb(date: climbDate, grade: selectedGrade, color: selectedColor)
                        climbs.append(newClimb)
                    }
                }
                
                // List of logged climbs
                if !climbs.isEmpty {
                    Section(header: Text("Your Climbs Today")) {
                        ForEach(climbs) { climb in
                            VStack(alignment: .leading) {
                                Text("Date: \(formattedDate(climb.date))")
                                Text("Grade: \(climb.grade)")
                                Text("Color: \(climb.color)")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Climb Log")
            .listStyle(CarouselListStyle()) // watchOS list style
        }
    }
    
    // Helper function to format date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}

// Preview for SwiftUI Canvas in Xcode
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

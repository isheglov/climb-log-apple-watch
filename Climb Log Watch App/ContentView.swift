import SwiftUI

// Data model to represent a climb
struct Climb: Identifiable {
    let id = UUID()
    let grade: String
    let color: String
}

struct ContentView: View {
    // Define available grades
    private let grades = ["7", "7+", "8-", "8", "8+", "9-"]
    @State private var selectedGrade: String? = nil

    // Define available colors with contrasting outlines
    private let colors: [(name: String, color: Color, border: Color)] = [
        ("Blue", .blue, .white),
        ("Red", .red, .white),
        ("Green", .green, .white),
        ("Yellow", .yellow, .black),
        ("Purple", .purple, .white),
        ("Black", .black, .white),  // White ring to make it visible
        ("Gray", .gray, .black)     // Black ring for contrast
    ]
    @State private var selectedColor: String? = nil

    // Array to store climb logs
    @State private var climbs: [Climb] = []

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) { // **Make entire screen scrollable**
            VStack(spacing: 10) {
                // Grade Selector
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(grades, id: \.self) { grade in
                                Text(grade)
                                    .font(.title3)
                                    .frame(width: 45, height: 45)
                                    .background(selectedGrade == grade ? Color.gray.opacity(0.6) : Color.white)
                                    .foregroundColor(.black)
                                    .cornerRadius(22.5)
                                    .shadow(radius: 2)
                                    .onTapGesture {
                                        selectedGrade = grade
                                    }
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                }

                // Color Selector (Scrollable)
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(colors, id: \.name) { color in
                                Circle()
                                    .fill(color.color)
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        Circle()
                                            .stroke(color.border, lineWidth: 2) // Contrasting ring
                                    )
                                    .overlay(
                                        Circle()
                                            .stroke(selectedColor == color.name ? Color.black : Color.clear, lineWidth: 3)
                                    )
                                    .onTapGesture {
                                        selectedColor = color.name
                                    }
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                }

                // Log Climb Button
                Button(action: {
                    if let grade = selectedGrade, let color = selectedColor {
                        climbs.append(Climb(grade: grade, color: color))
                        selectedGrade = nil
                        selectedColor = nil
                    }
                }) {
                    Text("Log Climb")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .disabled(selectedGrade == nil || selectedColor == nil)
                .opacity(selectedGrade == nil || selectedColor == nil ? 0.5 : 1.0)

                Spacer(minLength: 20) // Prevents layout compression
            }
            .padding()
        }
    }
}

// Preview for SwiftUI Canvas in Xcode
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

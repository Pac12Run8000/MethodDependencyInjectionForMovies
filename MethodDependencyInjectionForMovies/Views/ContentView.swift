import SwiftUI

struct ContentView: View {
    @State private var showMovieModal = false
    @State private var showTVModal = false
    @State private var showPersonModal = false
    var body: some View {
        VStack {
            CustomButton(label: "Movies", color: .blue) {
               showMovieModal = true
            }
            CustomButton(label: "Person", color: .green) {
               showPersonModal = true
            }
            CustomButton(label: "TV", color: .red) {
                showTVModal = true
            }
        }
        .sheet(isPresented: $showMovieModal) {
                MoviesView()
        }
        .sheet(isPresented: $showTVModal) {
                TVView()
        }
        .sheet(isPresented: $showPersonModal) {
            PersonView()
        }
    }
}

struct CustomButton: View {
    let label: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(label, action: action)
            .padding()
            .frame(width: 200)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}


#Preview {
    ContentView()
}

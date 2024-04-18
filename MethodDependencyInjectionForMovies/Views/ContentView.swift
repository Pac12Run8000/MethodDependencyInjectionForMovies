import SwiftUI

struct ContentView: View {
//    @StateObject var viewModel: MoviesViewModel
    @State private var showMovieModal = false
    
//    init() {
//            _viewModel = StateObject(wrappedValue: MoviesViewModel(networkingService: MovieNetworkingService()))
//    }
    var body: some View {
        VStack {
            CustomButton(label: "Movies", color: .blue) {
               showMovieModal = true
            }
            CustomButton(label: "People", color: .green) {
                print("People button tapped")
            }

            CustomButton(label: "TV", color: .red) {
                print("TV button tapped")
            }
        }
//        .onAppear {
//            Task {
//                await viewModel.loadMovies()
//            }
//        }
        .sheet(isPresented: $showMovieModal) {
                MoviesView()
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

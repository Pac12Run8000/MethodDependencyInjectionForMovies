import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: MoviesViewModel
    
    init() {
            _viewModel = StateObject(wrappedValue: MoviesViewModel(networkingService: MovieNetworkingService()))
    }
    var body: some View {
        VStack {
            CustomButton(label: "Movies", color: .blue) {
                print("Movies button tapped")
            }
            
            if viewModel.movies.isEmpty {
                    Text("No results")
                } else {
                    Text("Total Results for first movie: \(viewModel.movies[0].totalResults)")
                }

            CustomButton(label: "People", color: .green) {
                print("People button tapped")
            }

            CustomButton(label: "TV", color: .red) {
                print("TV button tapped")
            }
        }
        .onAppear {
            Task {
                await viewModel.loadMovies()
            }
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

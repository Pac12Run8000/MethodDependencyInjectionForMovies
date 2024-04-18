import SwiftUI

struct MoviesView: View {
    @State private var searchText = ""
    @StateObject var viewModel:MoviesViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: MoviesViewModel(networkingService: MovieNetworkingService()))
    }

    var body: some View {
        VStack {
            TextField("Search movies...", text: $searchText) {
                Task {
                    await viewModel.loadMovies()
                }
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .autocorrectionDisabled(true)
            .autocapitalization(.none)
            
            if !viewModel.outputArray.isEmpty {
                List(viewModel.outputArray, id:\.self) { item in
                    Text(item)
                }
            } else {
                List {
                    Text("No movies found")
                }
            }
            Spacer()
        }
        
    }
}




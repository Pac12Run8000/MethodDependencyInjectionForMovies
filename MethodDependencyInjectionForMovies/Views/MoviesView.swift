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
                    await viewModel.loadMovies(str: searchText)
                }
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .autocorrectionDisabled(true)
            .autocapitalization(.none)
            
            if !viewModel.outputArray.isEmpty {
                List(viewModel.outputArray, id:\.self) { item in
                    Text(item)
                        .font(.custom("Helvetica Neue", size: 16))
                }
            } else {
                List {
                    Text("movie not found ...")
                        .font(.custom("Helvetica Neue", size: 16))
                }
            }
            Spacer()
        }
        
    }
}




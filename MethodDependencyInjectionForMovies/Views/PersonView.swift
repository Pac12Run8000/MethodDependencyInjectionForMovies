import SwiftUI

struct PersonView: View {
    @State private var searchText = ""
    @StateObject var viewModel:PersonViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue:PersonViewModel(networkingService: PersonNetworkingService()))
    }

    var body: some View {
        VStack {
            TextField("Search tv shows...", text: $searchText) {
                Task {
                    await viewModel.loadMovies(str: searchText)
                }
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .autocorrectionDisabled(true)
            .autocapitalization(.none)
            .onAppear {
                
            }
            if !viewModel.outputArray.isEmpty {
                List(viewModel.outputArray, id:\.self) { item in
                    Text(item)
                        .font(.custom("Helvetica Neue", size: 16))
                }
            } else {
                List {
                    Text("No movies found")
                        .font(.custom("Helvetica Neue", size: 16))
                }
            }
            Spacer()
        }
    }
}

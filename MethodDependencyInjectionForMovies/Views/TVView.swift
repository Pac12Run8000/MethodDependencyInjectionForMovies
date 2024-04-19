import SwiftUI

struct TVView: View {
    @State private var searchText = ""
    @StateObject var viewModel:TVViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue:TVViewModel(networkingService: TVNetworkingService()))
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
                    Text("tv show not found ...")
                        .font(.custom("Helvetica Neue", size: 16))
                }
            }
            Spacer()
        }
    }
}

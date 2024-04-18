import Foundation

@MainActor
class MoviesViewModel: ObservableObject {
    @Published var movies: MovieSearchObject?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var outputArray:[String] = []
    
    private var networkingService:NetworkingServiceProtocol
    
    init(networkingService: NetworkingServiceProtocol) {
        self.networkingService = networkingService
    }
    
    func loadMovies() async {
        isLoading = true
        do {
            let movieSearchObject:MovieSearchObject = try await MovieNetworkingService.shared.retrieveMovieSearch(urlString: "https://api.themoviedb.org/3/search/movie?query=Lethal%20Weapon")
            self.movies = movieSearchObject
            guard let movies = self.movies else {
                return
            }
            
            self.outputArray = movies.results.map { result in
               return "title: \(result.originalTitle)\ndescription: \(result.overview)\n"
            }
//            outputArray.forEach { print($0) }
            errorMessage = nil
        } catch {
            errorMessage = "Failed to load movies"
        }
        isLoading = false
    }
}



//                        if viewModel.movies.isEmpty {
//                                Text("No results")
//                            } else {
//                                Text("Total Results for first movie: \(viewModel.movies[0].results[0].originalTitle)")
//                            }



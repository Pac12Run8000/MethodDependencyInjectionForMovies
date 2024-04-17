import Foundation

@MainActor
class MoviesViewModel: ObservableObject {
    @Published var movies: [MovieSearchObject] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var networkingService:NetworkingServiceProtocol
    
    init(networkingService: NetworkingServiceProtocol) {
        self.networkingService = networkingService
    }
    
    func loadMovies() async {
        isLoading = true
        do {
            let movieSearchObject:MovieSearchObject = try await MovieNetworkingService.shared.retrieveMovieSearch(urlString: "https://api.themoviedb.org/3/search/movie?query=Lethal%20Weapon")
            self.movies = [movieSearchObject]
            errorMessage = nil
        } catch {
            errorMessage = "Failed to load movies"
        }
        isLoading = false
    }
}


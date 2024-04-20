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
    
    func loadMovies(str:String) async {
        
        guard let encodedString = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Failed to encode the query string")
            return
        }
        isLoading = true
        do {
            let movieSearchObject:MovieSearchObject = try await MovieNetworkingService.shared.retrieveMovieSearch(urlString: "https://api.themoviedb.org/3/search/movie?query=\(encodedString)")
            self.movies = movieSearchObject
            guard let movies = self.movies else {
                return
            }
            
            self.outputArray = movies.results.map { result in
                if let originalTitle = result.originalTitle, let overview = result.overview {
                    return "title: \(originalTitle)\ndescription: \(overview)\n"
                } else {
                    return ""
                }
            }
//            outputArray.forEach { print($0) }
            errorMessage = nil
        } catch {
            errorMessage = "Failed to load movies"
        }
        isLoading = false
    }
}




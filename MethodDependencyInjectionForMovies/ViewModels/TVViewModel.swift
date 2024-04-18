import Foundation

@MainActor
class TVViewModel: ObservableObject {
    @Published var tvShows: MovieSearchObject?
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
            let movieSearchObject:MovieSearchObject = try await TVNetworkingService.shared.retrieveMovieSearch(urlString: "https://api.themoviedb.org/3/search/tv?query=\(encodedString)")
            self.tvShows = movieSearchObject
            guard let tvShows = self.tvShows else {
                return
            }
            
            self.outputArray = tvShows.results.map { result in
                if let overview = result.overview {
                    return "Show description: \(overview)"
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




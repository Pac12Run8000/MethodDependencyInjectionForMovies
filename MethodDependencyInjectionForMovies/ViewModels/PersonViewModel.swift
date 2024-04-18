import Foundation

@MainActor
class PersonViewModel: ObservableObject {
    @Published var persons: MovieSearchObject?
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
            let movieSearchObject:MovieSearchObject = try await TVNetworkingService.shared.retrieveMovieSearch(urlString: "https://api.themoviedb.org/3/search/person?query=\(encodedString)")
            self.persons = movieSearchObject
            guard let persons = self.persons else {
                return
            }
            print("Output: \(self.persons?.results[0])")
            self.outputArray = persons.results.map { result in
                if let overview = result.overview, let originalTitle = result.originalTitle, let releaseDate = result.releaseDate {
                    return "Title: \(originalTitle)\nRelease date: \(releaseDate) \nShow description: \(overview)"
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





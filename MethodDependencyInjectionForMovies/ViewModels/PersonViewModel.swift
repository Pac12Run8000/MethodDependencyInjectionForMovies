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
        var tempArray:[String] = []
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
            let results = persons.results
            for item in results {
                if let knownFor = item.knownFor {
                    for knownItem in knownFor {
                        let overview = knownItem.overview ?? ""
                        let originalName = knownItem.originalName ?? ""
                        tempArray.append("overview: \(overview)")
                    }
                } else {
                    tempArray = [String]()
                }
                self.outputArray = tempArray
            }
            errorMessage = nil
        } catch {
            errorMessage = "Failed to load movies"
        }
        isLoading = false
    }
}





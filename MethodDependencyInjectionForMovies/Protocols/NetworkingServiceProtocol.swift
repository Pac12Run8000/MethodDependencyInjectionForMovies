import Foundation

protocol NetworkingServiceProtocol {
    func retrieveMovieSearch(urlString: String) async throws -> MovieSearchObject
}

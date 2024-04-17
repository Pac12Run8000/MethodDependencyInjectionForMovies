import Foundation

final class MovieNetworkingService:NetworkingServiceProtocol {
    static let shared = MovieNetworkingService()
    
    
    func retrieveMovieSearch(urlString: String) async throws -> MovieSearchObject {
        guard let url = URL(string: urlString) else {
            throw CustomErrors.badURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYWZmMGYyYTJlMDUxOTMyNzk2ODYxZGI2YTI0NmQ3NSIsInN1YiI6IjU5MzY5N2UyOTI1MTQxNmJlZTAwZDA2ZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IZZ_QnAvoat2CoJDtjgQZxpcyrLVW7qQBLx3OHvYgHU", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw CustomErrors.badResponse
        }
//        if let httpResponse = response as? HTTPURLResponse {
//            print("HTTP Status Code: \(httpResponse.statusCode)")
//            print("HTTP Response Headers: \(httpResponse.allHeaderFields)")
//        }
//        if let rawJSON = String(data: data, encoding: .utf8) {
//            print("Raw JSON response: \(rawJSON)")
//        }
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieSearchObject.self, from: data)
            return decodedData
        } catch {
            // Additional logging to understand what went wrong during decoding
            print("Decoding error: \(error)")
        throw error
//        throw CustomErrors.cannotDecode
        }
    }
}

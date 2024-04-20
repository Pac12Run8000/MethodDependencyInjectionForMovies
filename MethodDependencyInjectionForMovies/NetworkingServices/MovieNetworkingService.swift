import Foundation

final class MovieNetworkingService:NetworkingServiceProtocol {
    static let shared = MovieNetworkingService()
    
    
    func retrieveMovieSearch(urlString: String) async throws -> MovieSearchObject {
        guard let url = URL(string: urlString) else {
            throw CustomErrors.badURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // Bearer Token is empty. You need to supply that.
        request.addValue("", forHTTPHeaderField: "Authorization")
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
            print("Decoding error: \(error)")
        throw error
        }
    }
}

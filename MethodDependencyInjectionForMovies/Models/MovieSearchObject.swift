import Foundation

// MARK: - Welcome
struct MovieSearchObject: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int
    let originalLanguage: OriginalLanguage?
    let originalTitle, overview: String?
    let popularity: Double
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let knownFor: [KF]?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case knownFor = "known_for"
    }
}

struct KF:Codable {
    let originalName:String?
    let overview:String?
    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case overview
    }
}
enum OriginalLanguage: String, Codable {
    case en = "en"
    case ja = "ja"
    case ru = "ru"
    case zh = "zh"
    case ko = "ko"
    case de = "de"
    case tr = "tr"
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = OriginalLanguage(rawValue: rawValue) ?? .unknown
    }
}

typealias MovieSearchObjects = [MovieSearchObject]

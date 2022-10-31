// Results.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Результат запроса
struct Results: Codable {
    let page: Int
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
    }
}

///  Фильм
struct Movie: Codable {
    let adult: Bool
    let genreIDS: [Int]
    let id: Int
    let originalTitle, overview: String
    let posterPath: String
    let releaseDate: String
    let title: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case adult
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}

/// Подробная Информация о фильме
struct MovieDetail: Codable {
    let backdropPath: String
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let revenue: Int
    let runtime: Int
    let status: String
    let tagline: String
    let title: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case budget
        case genres
        case homepage
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case status
        case tagline
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

/// Жанр
struct Genre: Codable {
    let name: String
}

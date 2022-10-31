// Constants.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Urls
enum Category {
    static let top = "top_rated"
    static let popular = "popular"
    static let upcoming = "upcoming"
}

/// Базовые ссылки
enum BaseURL {
    static let movies = "https://api.themoviedb.org/3/movie/"
    static let image = "https://image.tmdb.org/t/p/w500"
    static let apiKey = "?api_key=5e95e9b030369d612dfb2d6ecdfb4cf2&language=ru-RU"
}

/// Identifiers
enum Identifiers {
    static let headerImage = "HeaderImage"
    static let mainInfo = "MainInfo"
    static let credits = "Credits"
    static let credit = "Credits"
    static let cell = "Cell"
}

/// Тайтлы
enum Title {
    enum Button {
        static let popular = "Популярное"
        static let top = "В топе"
        static let upcomming = "Скоро"
    }

    enum Screen {
        static let movieList = "Список Фильмов"
    }
}

//
//  Movie.swift
//  WebConsuming
//
//  Created by Rodrigo Yukio Okido on 01/07/21.
//

import Foundation


/**
 Struct movie. Basic details about movie.
 */
struct Movie {
    var id: Int
    var title: String
    var genres: [Int] // Genres is defined by its IDs in the TMDB Movies API
    var description: String
    var image: String
    var rating_average: Double
}


/**
 Struct Genre. On TMDB API, each genre contains a specific ID.
 */
struct Genre {
    var id: Int
    var name: String
}


/**
 Enumerates the request types desired from the API
 */
enum Request_Type {
    case NOW_PLAYING, POPULAR_MOVIES
}


/**
 Request movie list from the TMDB API depending of your request type. The TMDB API requires an unique API Key.
 To do the correct request you must define a Request_Type on the request_name variable.
 */
struct RequestMoviesAPI_TMDB {
    
    let api_key: String = "3b3fe42086419ba7768f061008414e5b"
    var request_name: Request_Type
    
    mutating func setRequest (name: Request_Type) {
        self.request_name = name
    }
    
    func request_movies(page: Int = 0, completionHandler: @escaping ([Movie]) -> Void) {
        if page < 0 { fatalError("Page should not be lower than 0") }
        
        var request_url: String = ""

        switch (request_name) {
        
        case .POPULAR_MOVIES: request_url = "https://api.themoviedb.org/3/movie/popular?api_key=\(api_key)"
        case .NOW_PLAYING: request_url = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(api_key)"
        
        }
        
        
        let url = URL(string: request_url)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            typealias TMDBMovies = [String: Any]
            
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
                  let dictionary = json as? [String: Any],
                  let movies_details = dictionary["results"] as? [TMDBMovies]
            else {
                completionHandler([])
                return
            }
            
            var movies: [Movie] = []
            
            for movieDictionary in movies_details {
                
                if self.request_name == .POPULAR_MOVIES && movies.count >= 2 {
                    break
                }
                
                guard let movie_id = movieDictionary["id"] as? Int,
                      let movie_name = movieDictionary["original_title"] as? String,
                      let movie_genre = movieDictionary["genre_ids"] as? [Int],
                      let movie_description = movieDictionary["overview"] as? String,
                      let movie_image = movieDictionary["poster_path"] as? String,
                      let movie_rating = movieDictionary["vote_average"] as? Double

            
                else { continue }
                
                var movieImage_URL = "https://image.tmdb.org/t/p/w500"
                movieImage_URL.append(movie_image)
                
                let movie = Movie(id: movie_id, title: movie_name, genres: movie_genre, description: movie_description, image: movieImage_URL, rating_average: movie_rating)
                
                movies.append(movie)
            }
            
            completionHandler(movies)
        }
        .resume()
    }
}


struct GenresTMDB {
    let api_key: String = "3b3fe42086419ba7768f061008414e5b"
    static var genres: [Genre] = []
    
    func request_allGenres(page: Int = 0, completionHandler: @escaping ([Genre]) -> Void) {
        if page < 0 { fatalError("Page should not be lower than 0") }
        
        let urlString = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(api_key)"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            typealias TMDBGenres = [String: Any]
            
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
                  let dictionary = json as? [String: Any],
                  let movies_details = dictionary["genres"] as? [TMDBGenres]
            else {
                completionHandler([])
                return
            }
            
            var movies_genres: [Genre] = []
            
            for movieDictionary in movies_details {
                guard let genre_id = movieDictionary["id"] as? Int,
                      let genre_name = movieDictionary["name"] as? String
                    
            
                else { continue }
                                
                let genre = Genre(id: genre_id, name: genre_name)
                movies_genres.append(genre)
            }
            
            GenresTMDB.genres = movies_genres
            
            completionHandler(movies_genres)
        }
        .resume()
    }
}

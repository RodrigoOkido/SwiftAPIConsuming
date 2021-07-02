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


struct Genre {
    var id: Int
    var name: String
}


struct PopularMoviesTMDB {
    
    let api_key: String = "3b3fe42086419ba7768f061008414e5b"
    
    func request_PopularMovies(page: Int = 0, completionHandler: @escaping ([Movie]) -> Void) {
        if page < 0 { fatalError("Page should not be lower than 0") }
        
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(api_key)"
        let url = URL(string: urlString)!
        
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
            
            var popularMovies: [Movie] = []
            
            for movieDictionary in movies_details {
                
                if popularMovies.count > 2 {
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
                
                popularMovies.append(movie)
            }
            
            completionHandler(popularMovies)
        }
        .resume()
    }
}



struct NowPlayingTMDB {
    
    let api_key: String = "3b3fe42086419ba7768f061008414e5b"

    func request_NowPlayingMovies(page: Int = 0, completionHandler: @escaping ([Movie]) -> Void) {
        if page < 0 { fatalError("Page should not be lower than 0") }
        
        let urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(api_key)"
        let url = URL(string: urlString)!
        
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
            
            var nowPlaying: [Movie] = []
            
            for movieDictionary in movies_details {
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
                nowPlaying.append(movie)
            }
            
            
            completionHandler(nowPlaying)
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

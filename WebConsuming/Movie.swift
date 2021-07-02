//
//  Movie.swift
//  WebConsuming
//
//  Created by Rodrigo Yukio Okido on 01/07/21.
//

import Foundation


struct Movie {
    var id: Int
    var title: String
    var description: String
    var image: String
    var rating_average: Double
}


struct PopularMoviesTMDB {
    
    let api_key: String = "3b3fe42086419ba7768f061008414e5b"
    
    func request_PopularMovies(page: Int = 0, completionHandler: @escaping ([Movie]) -> Void) {
        if page < 0 { fatalError("Page should not be lower than 0") }
        
        var movieImage_URL = "https://image.tmdb.org/t/p/w500"
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
                guard let movie_id = movieDictionary["id"] as? Int,
                      let movie_name = movieDictionary["original_title"] as? String,
                      let movie_description = movieDictionary["overview"] as? String,
                      let movie_image = movieDictionary["poster_path"] as? String,
                      let movie_rating = movieDictionary["vote_average"] as? Double

            
                else { continue }
                
                movieImage_URL.append(movie_image)
                
                let movie = Movie(id: movie_id, title: movie_name, description: movie_description, image: movieImage_URL, rating_average: movie_rating)
                popularMovies.append(movie)

            }
            
            completionHandler(popularMovies)
        }
        .resume()
    }
}



struct NowPlayingTMDB {
    
    let api_key: String = "3b3fe42086419ba7768f061008414e5b"

    
    mutating func request_NowPlayingMovies(page: Int = 0, completionHandler: @escaping ([Movie]) -> Void) {
        if page < 0 { fatalError("Page should not be lower than 0") }
        
        var movieImage_URL = "https://image.tmdb.org/t/p/w500"
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
                      let movie_description = movieDictionary["overview"] as? String,
                      let movie_image = movieDictionary["poster_path"] as? String,
                      let movie_rating = movieDictionary["vote_average"] as? Double
                    
            
                else { continue }
                
                movieImage_URL.append(movie_image)
                
                let movie = Movie(id: movie_id, title: movie_name, description: movie_description, image: movieImage_URL, rating_average: movie_rating)
                nowPlaying.append(movie)
            }
            
            
            completionHandler(nowPlaying)
        }
        .resume()
    }
}

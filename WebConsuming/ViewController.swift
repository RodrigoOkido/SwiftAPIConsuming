//
//  ViewController.swift
//  WebConsuming
//
//  Created by Rodrigo Yukio Okido on 01/07/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    //MARK: TABLEVIEW VARIABLES
    var popular_movies: [Movie] = []
    var now_playing: [Movie] = []
    var genres: [Genre] = []
    var rowSelected: Int?

    //MARK: API DECLARATIONS
    let popularMoviesAPI = PopularMoviesTMDB()
    let nowPlayingAPI = NowPlayingTMDB()
    let loadGenres = GenresTMDB()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        popularMoviesAPI.request_PopularMovies { (movies) in
            self.popular_movies = movies

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
//        nowPlayingAPI.request_NowPlayingMovies { (movies) in
//            self.now_playing = movies
//
//            DispatchQueue.main.async {
//            self.tableView.reloadData()
//            }
//        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popular_movies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movie_cell") as! MovieTableViewCell
        
        let movie = popular_movies[indexPath.row]
        
        cell.movieTitle.text = movie.title
        cell.movieDescription.text = movie.description
        cell.movieRating.text = String(movie.rating_average)
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextViewController = segue.destination as? DetailViewController
        rowSelected = tableView.indexPathForSelectedRow?.row
        
        nextViewController?.aboutMovie = popular_movies[rowSelected!]

    }
    

}


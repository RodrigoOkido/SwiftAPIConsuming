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
    var sectionSelected: Int?
    var rowSelected: Int?

    //MARK: API DECLARATIONS
    let popularMoviesAPI = PopularMoviesTMDB()
    let nowPlayingAPI = NowPlayingTMDB()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomSectionHeader.self, forHeaderFooterViewReuseIdentifier: "section_header")
        
        popularMoviesAPI.request_PopularMovies { (movies) in
            self.popular_movies = movies

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        nowPlayingAPI.request_NowPlayingMovies { (movies) in
            self.now_playing = movies

            DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return popular_movies.count
        } else {
            return now_playing.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return " "
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "section_header") as! CustomSectionHeader
        if section == 0 {
            view.title.text = "Popular Movies"
            view.title.font = UIFont.boldSystemFont(ofSize: 17.0)
        } else {
            view.title.text = "Now Playing"
            view.title.font = UIFont.boldSystemFont(ofSize: 17.0)
        }
        return view

    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movie_cell") as! MovieTableViewCell
        
        let movie: Movie
        if (indexPath.section == 0) {
            movie = popular_movies[indexPath.row]
        } else {
            movie = now_playing[indexPath.row]
        }
        
        cell.configImage(url: movie.image)
        cell.movieTitle.text = movie.title
        cell.movieDescription.text = movie.description
        cell.movieRating.text = String(movie.rating_average)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextViewController = segue.destination as? DetailViewController
        sectionSelected = tableView.indexPathForSelectedRow?.section
        
        if sectionSelected == 0 {
            rowSelected = tableView.indexPathForSelectedRow?.row
            nextViewController?.aboutMovie = popular_movies[rowSelected!]
        } else {
            rowSelected = tableView.indexPathForSelectedRow?.row
            nextViewController?.aboutMovie = now_playing[rowSelected!]
        }
    }
    

}


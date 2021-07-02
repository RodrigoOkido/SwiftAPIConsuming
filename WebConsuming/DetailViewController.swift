//
//  DetailViewController.swift
//  WebConsuming
//
//  Created by Rodrigo Yukio Okido on 01/07/21.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: TABLEVIEW VARIABLES
    var aboutMovie: Movie?
    var genres: [Genre] = []

    //MARK: API DECLARATIONS
    let loadGenresAPI = GenresTMDB()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        tableView.dataSource = self
        tableView.delegate = self
        
        loadGenresAPI.request_allGenres { (genres) in
            self.genres = genres

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail_movie") as! DetailMovieTableViewCell
        
        cell.detailed_movieName.text = self.aboutMovie?.title
        cell.detailed_movieGenre.text = self.loadMovieGenre(movie: self.aboutMovie!, all_genre: self.genres)
        cell.detailed_movieRating.text = String(self.aboutMovie?.rating_average ?? 0)
        cell.detailed_movieDescription.text = self.aboutMovie?.description
        
        return cell
    }
    
    
    /**
     Based on the movie genres, it search for its IDs and return the name of the genre based on ID.
     Receives an Movie which containss a variable with the list of the genre IDs, and a list of the all existent genres.
     The list of all genres contains the ID and the name correspondent to this ID.
     */
    func loadMovieGenre(movie: Movie, all_genre: [Genre]) -> String {
        
        var genres: String = ""
        
        
        for (index, genre_id) in movie.genres.enumerated() {
            for search_genre in all_genre {
                if genre_id == search_genre.id {
                    if index == movie.genres.count - 1 {
                        genres.append("\(search_genre.name)")
                    } else {
                        genres.append("\(search_genre.name), ")
                    }
                }
            }
        }

        return genres
    }
 

}

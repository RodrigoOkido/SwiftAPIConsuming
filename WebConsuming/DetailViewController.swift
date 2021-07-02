//
//  DetailViewController.swift
//  WebConsuming
//
//  Created by Rodrigo Yukio Okido on 01/07/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailed_movieImage: UIImageView!
    @IBOutlet weak var detailed_movieTitle: UILabel!
    @IBOutlet weak var detailed_movieGenre: UILabel!
    @IBOutlet weak var detailed_movieRating: UILabel!
    @IBOutlet weak var detailed_movieOverview: UILabel!
    
    
    //MARK: TABLEVIEW VARIABLES
    var aboutMovie: Movie?
    var genres: [Genre] = []

    //MARK: API DECLARATIONS
    let loadGenresAPI = GenresTMDB()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGenresAPI.request_allGenres { (genres) in
            self.genres = genres

            DispatchQueue.main.async {
                self.detailed_movieTitle.text = self.aboutMovie?.title
                self.detailed_movieGenre.text = self.loadMovieGenre(movie: self.aboutMovie!)
                self.detailed_movieRating.text = String(self.aboutMovie?.rating_average ?? 0)
                self.detailed_movieOverview.text = self.aboutMovie?.description
                
            }
        }
    }
    
    
    func loadMovieGenre(movie: Movie) -> String {
        return "ABC"
    }
 

}

//
//  DetailViewController.swift
//  WebConsuming
//
//  Created by Rodrigo Yukio Okido on 01/07/21.
//

import UIKit

class DetailViewController: UIViewController {

    var aboutMovie: Movie?
    
    @IBOutlet weak var detailed_movieImage: UIImageView!
    @IBOutlet weak var detailed_movieTitle: UILabel!
    @IBOutlet weak var detailed_movieGenre: UILabel!
    @IBOutlet weak var detailed_movieRating: UILabel!
    @IBOutlet weak var detailed_movieOverview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailed_movieTitle.text = aboutMovie?.title
        detailed_movieRating.text = String(aboutMovie?.rating_average ?? 0)
        detailed_movieOverview.text = aboutMovie?.description

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

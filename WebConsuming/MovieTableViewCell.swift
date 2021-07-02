//
//  MovieTableViewCell.swift
//  WebConsuming
//
//  Created by Rodrigo Yukio Okido on 01/07/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    
    
    func configImage (url: String) {
        let id = URL(string: url)!
        
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: id)
            
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.movieImage.image = image
                self.movieImage.layer.cornerRadius = 10

            }
        }
    }
    
    override func prepareForReuse() {
        movieImage.image = nil
        movieTitle.text = "Movie Name"
        movieDescription.text = ""
        movieRating.text = ""
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

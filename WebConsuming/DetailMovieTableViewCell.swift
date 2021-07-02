//
//  DetailMovieTableViewCell.swift
//  WebConsuming
//
//  Created by Rodrigo Yukio Okido on 02/07/21.
//

import UIKit

class DetailMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var detailed_movieImage: UIImageView!
    @IBOutlet weak var detailed_movieName: UILabel!
    @IBOutlet weak var detailed_movieGenre: UILabel!
    @IBOutlet weak var detailed_movieRating: UILabel!
    @IBOutlet weak var detailed_movieDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

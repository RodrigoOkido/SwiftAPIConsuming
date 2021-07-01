//
//  ViewController.swift
//  WebConsuming
//
//  Created by Rodrigo Yukio Okido on 01/07/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let api_key: String = "3b3fe42086419ba7768f061008414e5b"
    var popular_movies: [Movie] = []
    var now_playing: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let urlPopular: String = "https://api.themoviedb.org/3/movie/popular?api_key=\(api_key)"
        let urlNowPlaying: String = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(api_key)"

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    

}


//
//  ViewController.swift
//  WebConsuming
//
//  Created by Rodrigo Yukio Okido on 01/07/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var popular_movies: [Movie] = []
    var now_playing: [Movie] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
//        rickAndMortyAPI.requestCharacters { (characters) in
//            self.characters = characters
//
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popular_movies.count + now_playing.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movie_cell") as! MovieTableViewCell
        return cell
    }
    
    

}


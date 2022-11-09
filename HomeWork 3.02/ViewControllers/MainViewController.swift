//
//  ViewController.swift
//  HomeWork 3.02
//
//  Created by Альбина Лега on 05.11.2022.
//

import UIKit

enum Link: String {
    case imageURL = "https://static01.nyt.com/images/2016/09/28/us/28xp-pepefrog/28xp-pepefrog-superJumbo.jpg"
    case jokeURL = "https://v2.jokeapi.dev/joke/Any?safe-mode"
}

class MainViewController: UIViewController {
//    MARK: - IB Outlets
    @IBOutlet var pepeImage: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
//    MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBackgroundColor()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }

//    MARK: - IB Actions
    @IBAction func getAJokebuttonPressed() {
        guard let url = URL(string: Link.jokeURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let joke = try decoder.decode(Joke.self, from: data)
                print(joke)
            } catch let error {
                print(error)
            }
        }.resume()
    }
}

//    MARK: - Fetch Image
extension MainViewController {
    private func fetchImage() {
        guard let url = URL(string: Link.imageURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.pepeImage.image = image
                self?.activityIndicator.stopAnimating()
            }
        }.resume()
    }
}


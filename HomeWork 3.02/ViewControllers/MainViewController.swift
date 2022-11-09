//
//  ViewController.swift
//  HomeWork 3.02
//
//  Created by Альбина Лега on 05.11.2022.
//

import UIKit

class MainViewController: UIViewController {
//    MARK: - IB Outlets
    @IBOutlet var pepeImage: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
//    MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBlueBackgroundColor()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }

//    MARK: - IB Actions
    @IBAction func getAJokebuttonPressed() {
        fetchJoke()
    }
}

// MARK: - Networking
extension MainViewController {
    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: Link.imageURL.rawValue) { [unowned self] result in
            switch result {
            case .success(let imageData):
                self.pepeImage.image = UIImage(data: imageData)
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchJoke() {
        NetworkManager.shared.fetch(Joke.self, from: Link.jokeURL.rawValue) { result in
            switch result {
            case .success(let joke):
                print(joke)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


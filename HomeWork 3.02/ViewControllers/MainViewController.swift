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
    
    private var joke: Joke?
    
//    MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBlueBackgroundColor()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }

//    MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let jokeVC = segue.destination as? JokeViewController else { return }
        jokeVC.fetchJoke()
    }
//    MARK: - IB Actions
    @IBAction func getAJokebuttonPressed() {
        fetchJoke()
    }
}

//    MARK: - Networking
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
        NetworkManager.shared.fetchJoke(from: Link.jokeURL.rawValue) { [weak self] result in
            switch result {
            case .success(let joke):
                self?.joke = joke
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


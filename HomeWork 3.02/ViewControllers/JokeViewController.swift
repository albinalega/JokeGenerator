//
//  JokeViewController.swift
//  HomeWork 3.02
//
//  Created by Альбина Лега on 09.11.2022.
//

import UIKit

final class JokeViewController: UIViewController {
    private var joke: Joke?
    
    @IBOutlet var setupLabel: UILabel!
    @IBOutlet var deliveryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGreenBackgroundColor()
    }
    
    @IBAction func oneMoreButtonPressed() {
        fetchJoke()
    }
}

//  MARK: - Networking
extension JokeViewController {
    func fetchJoke() {
        NetworkManager.shared.fetchJoke(from: Link.jokeURL.rawValue) { [weak self] result in
            switch result {
            case .success(let joke):
                self?.joke = joke
                self?.setupLabel.text = joke.setup
                self?.deliveryLabel.text = joke.delivery
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//NetworkManager.shared.fetch(Joke.self, from: Link.jokeURL.rawValue) { [weak self] result in
//    switch result {
//    case .success(let joke):
//        self?.setupLabel.text = joke.setup
//        self?.deliveryLabel.text = joke.delivery
//    case .failure(let error):
//        print(error.localizedDescription)
//    }
//}

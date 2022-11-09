//
//  JokeViewController.swift
//  HomeWork 3.02
//
//  Created by Альбина Лега on 09.11.2022.
//

import UIKit

final class JokeViewController: UIViewController {
    private var joke: Joke!
    
    @IBOutlet var setupLabel: UILabel!
    @IBOutlet var deliveryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGreenBackgroundColor()
        setupLabel.text = joke.setup
        deliveryLabel.text = joke.delivery
    }
    
    @IBAction func oneMoreButtonPressed() {
    }
}

//  MARK: - Networking
extension JokeViewController {
    func fetchJoke() {
        guard let url = URL(string: Link.jokeURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                self?.joke = try JSONDecoder().decode(Joke.self, from: data)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}

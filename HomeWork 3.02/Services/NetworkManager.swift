//
//  NetworkManager.swift
//  HomeWork 3.02
//
//  Created by Альбина Лега on 09.11.2022.
//

import Foundation
import Alamofire

// MARK: - Enumerations
enum Link: String {
    case imageURL = "https://static01.nyt.com/images/2016/09/28/us/28xp-pepefrog/28xp-pepefrog-superJumbo.jpg"
    case jokeURL = "https://v2.jokeapi.dev/joke/Any?safe-mode"
}

// MARK: - NetworkManager
class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
// MARK: - Fetching methods
    func fetchImage(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let imageData):
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchJoke(from url: String, completion: @escaping(Result<Joke, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let joke = Joke.getJoke(from: value) else { return }
                    completion(.success(joke))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

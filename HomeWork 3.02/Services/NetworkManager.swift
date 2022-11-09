//
//  NetworkManager.swift
//  HomeWork 3.02
//
//  Created by Альбина Лега on 09.11.2022.
//

import Foundation

// MARK: - Enumerations
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum Link: String {
    case imageURL = "https://static01.nyt.com/images/2016/09/28/us/28xp-pepefrog/28xp-pepefrog-superJumbo.jpg"
    case jokeURL = "https://v2.jokeapi.dev/joke/Any?safe-mode"
}

// MARK: - NetworkManager
class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
// MARK: - Fetching methods
    func fetchImage(from url: String, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ) else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetch<T: Decodable>(_ type: T.Type, from url: String, completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let type = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}

//
//  Joke.swift
//  HomeWork 3.02
//
//  Created by Альбина Лега on 05.11.2022.
//
import Foundation

struct Joke: Decodable {
    let setup: String
    let delivery: String
    
    init(jokeData: [String: Any]) {
        setup = jokeData["setup"] as? String ?? "sometimes it does not work"
        delivery = jokeData["delivery"] as? String ?? "try again"
    }
    
    static func getJoke(from value: Any) -> Joke? {
        guard let jokeData = value as? [String: Any] else { return nil }
        return Joke(jokeData: jokeData)
    }
}

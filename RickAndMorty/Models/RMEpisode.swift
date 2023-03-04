//
//  RMEpisode.swift
//  RickAndMorty
//
//  Created by Tugay Emre Yucedag on 3.03.2023.
//

import Foundation

struct RMEpisode: Codable {
    let id: String
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let create: String
}

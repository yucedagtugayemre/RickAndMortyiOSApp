//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by Tugay Emre Yucedag on 4.03.2023.
//

import Foundation

/*
 What is the purpose of  @frozen ?
 
 
 */

/// Represents unique API endpoint
@frozen enum RMEndpoint: String, CaseIterable, Hashable {
    /// Endpoint to get character info
    case character
    /// Endpoint to get location info
    case location
    /// Endpoint to get episode info
    case episode
}

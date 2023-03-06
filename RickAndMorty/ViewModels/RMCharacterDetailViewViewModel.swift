//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Tugay Emre Yucedag on 5.03.2023.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    private let character: RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    public var title: String {
        character.name.uppercased()
    }
}

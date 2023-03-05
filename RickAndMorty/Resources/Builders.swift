//
//  Builders.swift
//  RickAndMorty
//
//  Created by Tugay Emre Yucedag on 5.03.2023.
//

import Foundation

extension RMCharacterCollectionViewCellViewModel {
    static func make(with character: RMCharacter) -> RMCharacterCollectionViewCellViewModel {
        let viewModel = RMCharacterCollectionViewCellViewModel(
            characterName: character.name,
            characterStatus: character.status,
            characterImageUrl: URL(string: character.image)
        )
        return viewModel
    }
}

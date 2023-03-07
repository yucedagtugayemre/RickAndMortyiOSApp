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
    
    public var requestUrl: URL? {
        return URL(string: character.url)
    }
    
    public var title: String {
        character.name.uppercased()
    }
    
    public func fetchCharacterData() {
        
        guard let url = requestUrl, let request = RMRequest(url: url) else {
            print("Failed to Create")
            return
        }
        RMService.shared.execute(request,
                                 expecting: RMCharacter.self) { result in
            switch result {
            case .success(let success):
                print(String(describing: success))
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    
    }
}

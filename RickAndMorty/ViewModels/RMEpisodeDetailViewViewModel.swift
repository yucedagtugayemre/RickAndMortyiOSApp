//
//  RMEpisodeViewViewModel.swift
//  RickAndMorty
//
//  Created by Tugay Emre Yucedag on 16.03.2023.
//

import Foundation

final class RMEpisodeDetailViewViewModel {
    private let endpointUrl: URL?
    
    init(endpointUrl: URL?){
        self.endpointUrl = endpointUrl
        fetchEpisodeData()
    }
    
    private func fetchEpisodeData() {
        guard let endpointUrl = endpointUrl,
              let request = RMRequest(url: endpointUrl) else {
            return
        }
        
        RMService.shared.execute(
            request,
            expecting: RMEpisode.self) { result in
                switch result {
                case .success(let success):
                    print(String(describing: success))
                case .failure(let failure):
                    break
                }
            }
    }
}

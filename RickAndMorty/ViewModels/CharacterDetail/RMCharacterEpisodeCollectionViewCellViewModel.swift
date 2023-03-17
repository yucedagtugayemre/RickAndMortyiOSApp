//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Tugay Emre Yucedag on 7.03.2023.
//

import Foundation

protocol RMEpisodeDataRender {
    var name: String {get}
    var air_date: String {get}
    var episode: String {get}
}

final class RMCharacterEpisodeCollectionViewCellViewModel {
    private let episodeDataUrl: URL?
    
    private var isFetching = false
    
    private var dataBlock: ((RMEpisodeDataRender) -> Void)?
    
    private var episode: RMEpisode? {
        didSet {
            guard let model = episode else {
                return
            }
            self.dataBlock?(model)
        }
    }
    
    // MARK: - Public
    
    public func registerForData(_ block: @escaping (RMEpisodeDataRender) -> Void) {
        self.dataBlock = block
    }
    
    // MARK: - Init
    
    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
    
    public func fetchEpisode() {
        guard !isFetching else {
            if let model = episode {
                self.dataBlock?(model)
            }
            return
        }
        
        guard let url = episodeDataUrl, let rmRequest = RMRequest(url: url) else {
            return
        }
        isFetching = true
        RMService.shared.execute(rmRequest,
                                 expecting: RMEpisode.self) {[weak self] result in
            guard let storngSelf = self else {return}
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    storngSelf.episode = model
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
}

extension RMCharacterEpisodeCollectionViewCellViewModel: Hashable, Equatable {
    static func == (lhs: RMCharacterEpisodeCollectionViewCellViewModel, rhs: RMCharacterEpisodeCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.episodeDataUrl?.absoluteString ?? "")
    }
}

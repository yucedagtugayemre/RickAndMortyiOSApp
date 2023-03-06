//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Tugay Emre Yucedag on 4.03.2023.
//

import UIKit

protocol RMCharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didSelectCharacter(_ character: RMCharacter)
}

/// ViewModel to handle character listview logic
final class RMCharacterListViewViewModel: NSObject{
    
    public weak var delegate: RMCharacterListViewViewModelDelegate?

    
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                cellViewModels.append(RMCharacterCollectionViewCellViewModel.make(with: character))
            }
        }
    }
    
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
    
    private var apiInfo: RMGetAllCharactersResponse.Info = nil
    
    /// Fetch initial set of characters '20'
    public func fetchCharacters() {
        RMService.shared.execute(
            .listCharactersRequest,
            expecting: RMGetAllCharactersResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                self?.apiInfo = info
                self?.characters = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
        
    }
    
    /// Paginate if additional chartacters are needed
    public func fetchAdditionalCharacters() {
        //fetch characters here 
        
    }
    
    public var shouldShowLoadingMoreIndicator: Bool {
        apiInfo.next != nil
    }
}



// MARK: - CollectionView Implementation

extension RMCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
            for: indexPath
       ) as? RMCharacterCollectionViewCell else {
           fatalError("Unspported cell")
       }
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
    
}

 //MARK: - ScrollView

extension RMCharacterListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadingMoreIndicator else {
            return
        }
    }
}

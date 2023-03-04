//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Tugay Emre Yucedag on 3.03.2023.
//

import UIKit

/// Controller to show and search for characters
class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        let request = RMRequest(endpoint: .character,queryParameters: [URLQueryItem(name: "name", value: "rick"), URLQueryItem(name: "status", value: "alive")])
        
        print(request.url)
        
        RMService.shared.execute(request, expecting: RMCharacter.self) { result in
            
        }
    }
    


}

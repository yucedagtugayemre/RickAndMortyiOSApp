//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by Tugay Emre Yucedag on 3.03.2023.
//

import UIKit
/// Controller to show and search for locations
class RMLocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Locations"
        addSearchButton()
    }
    


    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        
    }
}

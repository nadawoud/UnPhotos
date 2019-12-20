//
//  ViewController.swift
//  UnPhotos
//
//  Created by Nada Yehia Dawoud on 11/18/19.
//  Copyright © 2019 Mobile Apps Kitchen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    // MARK: Properties
    
    let viewModel = ViewModel(client: UnsplashClient())
//    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = photoCollectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        photoCollectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
//        setupSearchController()
        
        // Init View Model
        viewModel.showLoading = {
            if self.viewModel.isLoading {
                self.loadingActivityIndicator.startAnimating()
                self.photoCollectionView.alpha = 0.0
            } else {
                self.loadingActivityIndicator.stopAnimating()
                self.photoCollectionView.alpha = 1.0
            }
        }
        
        viewModel.showError = { error in
            print(error)
        }
        
        viewModel.reloadData = {
            self.photoCollectionView.reloadData()
        }
        
        viewModel.fetchPhotos()
    }
    
//    func setupSearchController() {
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search"
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
//    }
}

// MARK: - Flow Layout Delegate

extension ViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let image = viewModel.photoViewModels[indexPath.item].image
        let height = image.size.height
        
        return height
    }
}

// MARK: Data Source

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photoViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        let image = viewModel.photoViewModels[indexPath.item].image
        cell.imageView.image = image
        
        return cell
    }
}

// MARK: Search Results Updating

//extension ViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        // TODO
//    }
//}


//
//  ViewModel.swift
//  UnPhotos
//
//  Created by Nada Yehia Dawoud on 11/18/19.
//  Copyright © 2019 Mobile Apps Kitchen. All rights reserved.
//

import UIKit

struct PhotoViewModel {
    let smallImage: UIImage
    let thmbImage: UIImage
    let description: String?
    let altDescription: String?
    let artist: String
}

class ViewModel {
    // MARK: Properties

    private let client: APIClient
    private var photos: Photos = [] {
        didSet {
            self.fetchPhoto()
        }
    }
    var photoViewModels: [PhotoViewModel] = []

    // MARK: UI

    var isLoading: Bool = false {
        didSet {
            showLoading?()
        }
    }
    var showLoading: (() -> Void)?
    var reloadData: (() -> Void)?
    var showError: ((Error) -> Void)?

    init(client: APIClient) {
        self.client = client
    }

    func fetchPhotos() {
        if let client = client as? UnsplashClient {
            self.isLoading = true
            let endpoint = ListPhotosEndpoint.photos(id: UnsplashClient.apiKey, order: .latest)
            client.fetch(with: endpoint) { (either) in
                switch either {
                case .success(let photos):
                    self.photos = photos
                case .error(let error):
                    self.showError?(error)
                }
            }
        }
    }

    private func fetchPhoto() {
        let group = DispatchGroup()
        self.photos.forEach { (photo) in
            DispatchQueue.global(qos: .background).async(group: group) {
                group.enter()
                guard let imageData = try? Data(contentsOf: photo.urls.small),
                    let thumbData = try? Data(contentsOf: photo.urls.thumb) else {
                    self.showError?(APIError.imageDownload)
                    return
                }

                guard let image = UIImage(data: imageData),
                    let thumb = UIImage(data: thumbData) else {
                    self.showError?(APIError.imageConvert)
                    return
                }
                
                self.photoViewModels.append(PhotoViewModel(smallImage: image, thmbImage: thumb,description: photo.description, altDescription: photo.altDescription, artist: photo.user.name))
                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.isLoading = false
            self.reloadData?()
        }
    }


}

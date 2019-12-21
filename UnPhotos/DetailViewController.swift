//
//  DetailViewController.swift
//  UnPhotos
//
//  Created by Nada Yehia Dawoud on 11/18/19.
//  Copyright © 2019 Mobile Apps Kitchen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var photoModel: PhotoViewModel? {
        didSet {
            configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        if let photoModel = photoModel,
            let detailDescriptionLabel = detailDescriptionLabel,
            let imageView = imageView {
            detailDescriptionLabel.text = photoModel.description ?? photoModel.altDescription
            imageView.image = photoModel.smallImage
            title = photoModel.artist
        }
    }
}

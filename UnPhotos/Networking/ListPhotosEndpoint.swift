//
//  ListPhotosEndpoint.swift
//  UnPhotos
//
//  Created by Nada Yehia Dawoud on 12/20/19.
//  Copyright © 2019 Mobile Apps Kitchen. All rights reserved.
//

import Foundation

enum Order: String {
    case popular, latest, oldest
}

enum ListPhotosEndpoint: Endpoint {
    //TODO: Add page
    case photos(id: String, order: Order)

    var baseUrl: String {
        return UnsplashClient.baseUrl
    }

    var path: String {
        switch self {
        case .photos:
            return "/photos"
        }
    }

    var urlParameters: [URLQueryItem] {
        switch self {
        case .photos(let id, let order):
            return [
                URLQueryItem(name: "client_id", value: id),
                URLQueryItem(name: "order_by", value: order.rawValue),
                URLQueryItem(name: "per_page", value: "30")
            ]
        }
    }
}

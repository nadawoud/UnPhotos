//
//  UnsplashPhotos.swift
//  UnPhotos
//
//  Created by Nada Yehia Dawoud on 11/18/19.
//  Copyright © 2019 Mobile Apps Kitchen. All rights reserved.
//

import Foundation

typealias Photos = [Photo]

struct Photo: Codable {
    let id: String
    let urls: URLS
    let description: String?
    let altDescription: String?
    let user: Artist
}

struct URLS: Codable {
    let raw: URL
    let full: URL
    let regular: URL
    let small: URL
    let thumb: URL
}

struct Artist: Codable {
    let id: String
    let username: String
    let name: String
}


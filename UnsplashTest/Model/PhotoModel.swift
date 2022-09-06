//
//  PhotoModel.swift
//  UnsplashTest
//
//  Created by Andrey Lobanov on 05.09.2022.
//

import Foundation

struct PhotoModel: Codable {
    let results: [Photo]
}

struct Photo: Codable {
    let id: String
    let created_at: String
    let width: Int
    let height: Int
    let urls: Urls
    let user: User
    let downloads: Int?
}

struct Urls: Codable {
    let raw, full, regular, small, thumb: String
}

struct User: Codable {
    let name: String
    let location: String?
}

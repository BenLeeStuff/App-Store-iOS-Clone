//
//  AppGroup.swift
//  AppStoreClone
//
//  Created by Ben Lee on 7/12/23.
//

import Foundation

struct AppGroup: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Codable {
    let artistName, name, artworkUrl100: String
}

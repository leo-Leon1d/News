//
//  Model.swift
//  News
//
//  Created by Леонид Исраелян on 12.06.2022.
//

import Foundation

struct Model: Decodable {
    var status: String
    var totalResults: Int
    var articles: [Articles]
}

struct Articles: Decodable {
    var source: Source
    var author: String?
    var title: String
    var description: String?
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var content: String?
}

struct Source: Decodable {
    var id: String?
    var name: String
}

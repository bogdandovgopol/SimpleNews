//
//  Article.swift
//  TableView
//
//  Created by Bogdan on 1/7/20.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import Foundation

struct Article: Codable {
    let title: String
    let description: String?
    let url: URL?
    let urlToImage: URL?
    let publishedAt: Date
}

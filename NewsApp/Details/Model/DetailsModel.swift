//
//  DetailsModel.swift
//  NewsApp
//
//  Created by Nihad Ismayilov on 01.04.22.
//

import Foundation

struct DetailsModel: Decodable {
    let articles: [NewsData]?
}

struct DetailsData: Decodable {
    let title: String?
    let author: String?
    let published_date: String?
    let link: String?
    let excerpt: String?
    let summary: String?
    let topic: String?
    let media: String?
}

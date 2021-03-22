//
//  Items.swift
//  ColorfulColorado
//
//  Created by Gabo Cuadros Cardenas on 3/21/21.
//

import Foundation

struct Items: Codable {
    let title: String
    let link: String
    let media: Media
    let dateTaken: String
    let description: String
    let published: String
    let author: String
    let authorId: String
    let tags: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case link
        case media
        case dateTaken = "date_taken"
        case description
        case published
        case author
        case authorId = "author_id"
        case tags
    }
    
}

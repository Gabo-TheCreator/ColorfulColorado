//
//  RecentUploads.swift
//  ColorfulColorado
//
//  Created by Gabo Cuadros Cardenas on 3/21/21.
//

import Foundation

struct RecentUploads: Codable {
    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
    let items: [Items]
}

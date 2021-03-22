//
//  Media.swift
//  ColorfulColorado
//
//  Created by Gabo Cuadros Cardenas on 3/21/21.
//

import Foundation

struct Media: Codable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url = "m"
    }
}

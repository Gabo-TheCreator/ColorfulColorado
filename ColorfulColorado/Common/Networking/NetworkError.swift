//
//  NetworkError.swift
//  ColorfulColorado
//
//  Created by Gabo Cuadros Cardenas on 3/21/21.
//

import Foundation

enum NetworkError: Error {
    case brokenURL
    case error(String)
    case parseError
    case noData
}

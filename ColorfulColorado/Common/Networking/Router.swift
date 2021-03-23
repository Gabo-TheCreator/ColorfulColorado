//
//  Router.swift
//  ColorfulColorado
//
//  Created by Gabo Cuadros Cardenas on 3/21/21.
//

import Foundation

enum Router {
    
    case fetchImages
    case fetchColoradoImages
    
    var method: String {
        switch self {
        case .fetchColoradoImages:
            return Constants.Networking.fetchColoradoImages.method
        case .fetchImages:
            return Constants.Networking.fetchImages.method
        }
    }
    
    var scheme: String {
        switch self {
        case .fetchColoradoImages:
            return Constants.Networking.fetchColoradoImages.scheme
        case .fetchImages:
            return Constants.Networking.fetchImages.scheme
        }
    }
    
    var host: String {
        switch self {
        case .fetchColoradoImages:
            return Constants.Networking.fetchColoradoImages.host
        case .fetchImages:
            return Constants.Networking.fetchImages.host
        }
    }
    
    var path: String {
        switch self {
        case .fetchColoradoImages:
            return Constants.Networking.fetchColoradoImages.path
        case .fetchImages:
            return Constants.Networking.fetchImages.path
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .fetchColoradoImages:
            return Constants.Networking.fetchColoradoImages.parameters
        case .fetchImages:
            return Constants.Networking.fetchImages.parameters
        }
    }
        
}

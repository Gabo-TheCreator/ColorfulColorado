//
//  Networking+Constants.swift
//  ColorfulColorado
//
//  Created by Gabo Cuadros Cardenas on 3/21/21.
//

import Foundation

extension Constants {
    struct Networking {
        struct fetchColoradoImages {
            static let method = "GET"
            static let scheme = "https"
            static let host = "api.flickr.com"
            static let path = "/services/feeds/photos_public.gne"
            static let parameters: [URLQueryItem] = [URLQueryItem(name: "tags", value: "coloradomountains"),
                                                     URLQueryItem(name: "format", value: "json"),
                                                     URLQueryItem(name: "nojsoncallback", value: "1")]
        }
        
        struct fetchImages {
            static let method = "GET"
            static let scheme = "https"
            static let host = "api.flickr.com"
            static let path = "/services/feeds/photos_public.gne"
            static let parameters: [URLQueryItem] = [URLQueryItem(name: "format", value: "json")]
        }
    }
}

//
//  NetworkHelpers.swift
//  ColorfulColorado
//
//  Created by Gabo Cuadros Cardenas on 3/23/21.
//

import Foundation

class NetworkHelpers {
    class func createUrlFrom(router: Router) -> URL? {
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        
        guard let url = components.url else {
            return nil
        }
        
        return url
    }
}

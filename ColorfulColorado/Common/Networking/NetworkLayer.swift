//
//  NetworkLayer.swift
//  ColorfulColorado
//
//  Created by Gabo Cuadros Cardenas on 3/21/21.
//

import Foundation

class NetworkLayer<T: Codable>{
    
    class func request(router: Router, completion: @escaping (NetworkReponse<T>) -> ()) {
        
        guard let url = NetworkHelpers.createUrlFrom(router: router) else {
            completion(.failure(.brokenURL))
            return
        }
        
        print(url)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            if let err = error {
                completion(.failure(.error(err.localizedDescription)))
                return
            }
            
            guard response != nil, let data = data else {
                completion(.failure(.noData))
                return
            }
            
            guard let responseObject: T = NetworkLayer<T>.decodeFrom(data: data) else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(responseObject))
        }
        dataTask.resume()
    }
    
    class func decodeFrom(data: Data) -> T? {
        do {
            let responseObject = try JSONDecoder().decode(T.self, from: data)
            return responseObject
        } catch {
            return nil
        }
    }
}

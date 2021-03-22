//
//  NetworkLayer.swift
//  ColorfulColorado
//
//  Created by Gabo Cuadros Cardenas on 3/21/21.
//

import Foundation

class NetworkLayer<T: Codable>{
    
    class func request(router: Router, completion: @escaping (NetworkReponse<T>) -> ()) {
        var components = URLComponents()
        components.scheme = router.scheme   
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        
        guard let url = components.url else {
            completion(.failure(.brokenURL))
            return
        }
        
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
            
            do {
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(responseObject))
                }
            } catch {
                completion(.failure(.parseError))
            }
        }
        dataTask.resume()
    }
}

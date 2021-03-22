//
//  NetworkResponse.swift
//  ColorfulColorado
//
//  Created by Gabo Cuadros Cardenas on 3/22/21.
//

import Foundation

enum NetworkReponse<T> {
    case success(T)
    case failure(NetworkError)
}

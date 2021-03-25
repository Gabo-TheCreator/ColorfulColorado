//
//  Constants.swift
//  ColorfulColorado
//
//  Created by Gabo Cuadros Cardenas on 3/22/21.
//

import Foundation

struct Constants {
    struct MainViewController {
        struct Identifiers {
            static let imageWithTitleCollectionViewCell = "imageWithTitleCollectionViewCell"
            static let tryAgainCollectionViewCell = "ErrorCollectionViewCell"
        }
        
        struct Images {
            static let placeholder = "placeholder"
        }
    }
    
    struct Messages {
        struct Errors {
            static let ops = "Ops... "
            static let brokenUrl = ops + "The Url seems to be invalid."
            static let error = ops + "Error: %@"
            static let parseError = ops + "Could not read data."
            static let noData = ops + "It seems like there's no posts for this search, please try again later."
        }
    }
    
    struct Button {
        static let ok = "Ok"
    }
}

//
//  ImageWithTitleCollectionViewCell.swift
//  ColorfulColorado
//
//  Created by Gabo Cuadros Cardenas on 3/24/21.
//

import UIKit

class ImageWithTitleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func prepareForReuse() {
        image.sd_cancelCurrentImageLoad()
    }
}

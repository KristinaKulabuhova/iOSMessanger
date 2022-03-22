//
//  PhotoCollectionViewCell.swift
//  Messager
//
//  Created by Kristina on 10.03.2022.
//

import UIKit

final class PhoroCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        
        let images = [
            UIImage(named: "Image"),
            UIImage(named: "Image1"),
            UIImage(named: "Image2"),
            UIImage(named: "Image3"),
            UIImage(named: "Image4"),
            UIImage(named: "Image5"),
            UIImage(named: "Image6")
        ].compactMap({ $0 })
        
        imageView.image = images.randomElement()
        imageView.layer.cornerRadius = 10
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
}

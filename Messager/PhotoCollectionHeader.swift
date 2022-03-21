//
//  PhotoCollectionHeader.swift
//  Messager
//
//  Created by Kristina on 10.03.2022.
//

import UIKit

class PhotoCollectionHeader: UICollectionReusableView {
    static let identifier = "header"
    
     private var label: UILabel = {
         let label: UILabel = UILabel()
         label.textColor = .black
         label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
         label.sizeToFit()
         label.text = "Header"
         return label
     }()
    
    public func configure() {
        backgroundColor = .systemGreen
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
    }
}

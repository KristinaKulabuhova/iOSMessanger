//
//  PhotoCollectionHeader.swift
//  Messager
//
//  Created by Kristina on 10.03.2022.
//

import UIKit

final class PhotoCollectionHeader: UICollectionReusableView {
    static let identifier = "header"
    
     private var label: UILabel = {
         let label: UILabel = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.textColor = .black
         label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
         label.text = "Header"
         
         return label
     }()
    
    public func initialSetUp() {
        backgroundColor = .systemGreen
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            label.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}

//
//  ViewController.swift
//  Messager
//
//  Created by Kristina on 25.02.2022.
//

import UIKit

enum Constants {
    static let topStackView: CGFloat = 200
    static let spacingStackView: CGFloat = 20
    static let cornerRadiusButton: CGFloat = 10
}

struct PaddingButton {
    static let top: CGFloat = 10
    static let left: CGFloat = 20
    static let bottom: CGFloat = 10
    static let right: CGFloat = 20
}

final class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var messageButton: UIButton = {
        var messageButton = UIButton(type: .system)
        messageButton.translatesAutoresizingMaskIntoConstraints = false
        messageButton.backgroundColor = .systemTeal
        messageButton.setTitleColor(.white, for: .normal)
        messageButton.setTitle("Сообщение", for: .normal)
        messageButton.layer.cornerRadius = Constants.cornerRadiusButton
        messageButton.contentEdgeInsets = UIEdgeInsets(top: PaddingButton.top, left: PaddingButton.left, bottom: PaddingButton.bottom, right: PaddingButton.right)
        return messageButton
        
    }()
    
    var callButton: UIButton = {
        var callButton = UIButton(type: .system)
        callButton.translatesAutoresizingMaskIntoConstraints = false
        callButton.backgroundColor = .systemGray
        callButton.setTitleColor(.white, for: .normal)
        callButton.setTitle("Позвонить", for: .normal)
        callButton.layer.cornerRadius = Constants.cornerRadiusButton
        callButton.contentEdgeInsets = UIEdgeInsets(top: PaddingButton.top, left: PaddingButton.left, bottom: PaddingButton.bottom, right: PaddingButton.right)
        return callButton
    }()
    
  
    var photosCollection: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        var photosCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        photosCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return photosCollection
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photosCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = .systemBlue
        return cell
    }
    
 
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
            return nil
    }

    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        let stackView = UIStackView()
        
        photosCollection.delegate = self
        photosCollection.dataSource = self
        
        setupButtons(stackView)
        //setupPhotosCollection(stackView)
    }
    
    func setupButtons(_ stackView: UIStackView) {
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = Constants.spacingStackView

        stackView.addArrangedSubview(messageButton)
        stackView.addArrangedSubview(callButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: Constants.topStackView).isActive = true
    }
    
//    func setupPhotosCollection(_ stackView: UIStackView) {
//        self.view.addSubview(photosCollection)
//        photosCollection.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        photosCollection.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
//        photosCollection.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        photosCollection.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 100).isActive = true
//    }
}



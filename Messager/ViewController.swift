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

//let insents = UIEdgeInsets(top: 200, left: 10, bottom: 0, right: 10)

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
        photosCollection.register(PhoroCollectionViewCell.self, forCellWithReuseIdentifier: PhoroCollectionViewCell.identifier)
        return photosCollection
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhoroCollectionViewCell.identifier, for: indexPath)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insertForSectionAt section: Int) -> UIEdgeInsets {
//        return insents
//    }
    
 
    
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
        setupPhotosCollection(stackView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: Constants.topStackView)
        ])
    }
    
    func setupPhotosCollection(_ stackView: UIStackView) {
        photosCollection.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(photosCollection)
        
//        NSLayoutConstraint.activate([
//            //photosCollection.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            photosCollection.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50),
//            photosCollection.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50),
//            photosCollection.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 300),
//            photosCollection.widthAnchor.constraint(equalToConstant: 200)
//        ])
        
        NSLayoutConstraint.activate([
                photosCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
                //photosCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                photosCollection.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
                photosCollection.heightAnchor.constraint(equalToConstant: 50),
                photosCollection.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10)
            ])
        
        
    }
}



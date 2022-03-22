//
//  ViewController.swift
//  Messager
//
//  Created by Kristina on 25.02.2022.
//

import UIKit


final class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
    
    struct settingButton {
        var title: String
        var backgroundColor: UIColor
        var TitleColor: UIColor
    }
    
    func setUpButton(setting: settingButton) -> UIButton {
        let messageButton = UIButton(type: .system)
        messageButton.translatesAutoresizingMaskIntoConstraints = false
        messageButton.backgroundColor = setting.backgroundColor
        messageButton.setTitleColor(setting.TitleColor, for: .normal)
        messageButton.setTitle(setting.title, for: .normal)
        messageButton.layer.cornerRadius = Constants.cornerRadiusButton
        messageButton.contentEdgeInsets = UIEdgeInsets(top: PaddingButton.top, left: PaddingButton.left, bottom: PaddingButton.bottom, right: PaddingButton.right)
        return messageButton
    }
    var messageButton: UIButton?
    var callButton: UIButton?
    var photosCollection: UICollectionView?
    
    let infoMessageButton = settingButton(title: "Сообщение", backgroundColor: .systemTeal, TitleColor: .white)
    let infoCallButton = settingButton(title: "Позвонить", backgroundColor: .systemGray, TitleColor: .white)

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhoroCollectionViewCell.identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PhotoCollectionHeader.identifier, for: indexPath) as! PhotoCollectionHeader
            sectionHeader.initialSetUp()
            return sectionHeader
        } else { //No footer in this case but can add option for that
             return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 50)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        
        messageButton = setUpButton(setting: infoMessageButton)
        callButton = setUpButton(setting: infoCallButton)
        
        setUpStackView()
        setUpPhotoCollectionView()
        
        addStackViewSubviews()
    }
    
    let stackView = UIStackView()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutStackView()
        layoutPhotosCollectionView()
    }
    
    func setUpPhotoCollectionView() {
        let layoutCollection = UICollectionViewFlowLayout()
        layoutCollection.scrollDirection = .horizontal
        photosCollection = UICollectionView(frame: .zero, collectionViewLayout: layoutCollection)
        photosCollection?.register(PhoroCollectionViewCell.self, forCellWithReuseIdentifier: PhoroCollectionViewCell.identifier)
        photosCollection?.register(PhotoCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PhotoCollectionHeader.identifier)
        photosCollection?.delegate = self
        photosCollection?.dataSource = self
        photosCollection?.translatesAutoresizingMaskIntoConstraints = false
        if let collection = photosCollection {view.addSubview(collection)}
    }
    
    func setUpStackView() {
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = Constants.spacingStackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
        
    func addStackViewSubviews() {
        view.addSubview(stackView)
        if let button = messageButton {stackView.addArrangedSubview(button)}
        if let button = callButton {stackView.addArrangedSubview(button)}
    }
    
    func layoutStackView() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: Constants.topStackView)
        ])
    }
    
    func layoutPhotosCollectionView() {
        if let collection = photosCollection {
            NSLayoutConstraint.activate([
                collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
                collection.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
                collection.heightAnchor.constraint(equalToConstant: 50),
                collection.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10)
            ])
        }
    }
}

//
//  ViewController.swift
//  Messager
//
//  Created by Kristina on 25.02.2022.
//

import UIKit


final class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    enum Constants {
        static let topStackView: CGFloat = 250
        static let spacingStackView: CGFloat = 24
        static let cornerRadiusButton: CGFloat = 10
        static let sizeProfilePhoto: CGSize = CGSize(width: 90, height: 90)
    }

    struct PaddingButton {
        static let top: CGFloat = 13
        static let left: CGFloat = 20
        static let bottom: CGFloat = 13
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
    var profilePhoto: UIImageView = UIImageView(image: UIImage(named: "Image"))
    
    let infoMessageButton = settingButton(title: "Сообщение", backgroundColor: .systemTeal, TitleColor: .white)
    let infoCallButton = settingButton(title: "Позвонить", backgroundColor: .systemGray, TitleColor: .white)
    
    
    //---------------------COLLECTION_PHOTOS---------------------------//
    
    func setUpPhotoCollectionView() {
        let layoutCollection = UICollectionViewFlowLayout()
        layoutCollection.scrollDirection = .horizontal
        photosCollection = UICollectionView(frame: .zero, collectionViewLayout: layoutCollection)
        photosCollection?.register(PhoroCollectionViewCell.self, forCellWithReuseIdentifier: PhoroCollectionViewCell.identifier)
        photosCollection?.register(PhotoCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PhotoCollectionHeader.identifier)
        photosCollection?.delegate = self
        photosCollection?.dataSource = self
        photosCollection?.contentMode = .scaleAspectFill
        photosCollection?.translatesAutoresizingMaskIntoConstraints = false
        if let collection = photosCollection {view.addSubview(collection)}
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
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
        return CGSize(width: view.frame.size.width, height: 80)
    }
    
    func layoutPhotosCollectionView() {
        if let collection = photosCollection {
            NSLayoutConstraint.activate([
                collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 350),
                collection.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
                collection.heightAnchor.constraint(equalToConstant: 80),
                collection.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10)
            ])
        }
    }
    
    //-----------------------------------------------------------------//
    
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        
        messageButton = setUpButton(setting: infoMessageButton)
        callButton = setUpButton(setting: infoCallButton)
        
        setUpStackIconTextView()
        setUpTextsProfile()
        setUpProfilePhoto()
        setUpStackButtonsView()
        setUpStackInfoView()
        setUpPhotoCollectionView()
        
        addStackButtonsViewSubviews()
        addStackInfoViewSubviews()
        addStackIconTextViewSubviews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutStackButtonsView()
        layoutStackInfoView()
        layoutPhotosCollectionView()
        layoutProfilePhoto()
    }
    
    
    
    //---------------------PROFILE_PHOTO------------------------//
    
    func setUpProfilePhoto() {
        profilePhoto.layer.cornerRadius = Constants.sizeProfilePhoto.height / 2
        profilePhoto.clipsToBounds = true
        profilePhoto.translatesAutoresizingMaskIntoConstraints = false
        profilePhoto.contentMode = .scaleAspectFill
        view.addSubview(profilePhoto)
    }
    
    func layoutProfilePhoto() {
        NSLayoutConstraint.activate([
            profilePhoto.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 33),
            profilePhoto.bottomAnchor.constraint(equalTo: self.view.topAnchor, constant: Constants.topStackView - 40),
            profilePhoto.heightAnchor.constraint(equalToConstant: Constants.sizeProfilePhoto.height),
            profilePhoto.widthAnchor.constraint(equalToConstant: Constants.sizeProfilePhoto.width)
        ])
    }
    
    //----------------------------------------------------------//
    
    //---------------------STACK_ICON_TEXT---------------------------//
    var stackIconTextView = UIStackView()
    
    func setUpStackIconTextView() {
        stackIconTextView.axis = NSLayoutConstraint.Axis.horizontal
        stackIconTextView.distribution = UIStackView.Distribution.fillProportionally
        stackButtonsView.alignment = UIStackView.Alignment.leading
        stackButtonsView.isLayoutMarginsRelativeArrangement = true
        stackIconTextView.spacing = 7
        stackIconTextView.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = true
        moreInfomation.translatesAutoresizingMaskIntoConstraints = true
        icon.setContentHuggingPriority(.defaultLow, for: .horizontal)
        moreInfomation.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
        
    func addStackIconTextViewSubviews() {
        stackIconTextView.addArrangedSubview(icon)
        stackIconTextView.addArrangedSubview(moreInfomation)
    }
    
    func layoutStackIconTextView() {
        NSLayoutConstraint.activate([
            stackIconTextView.leftAnchor.constraint(equalTo: stackInfoView.leftAnchor),
            icon.widthAnchor.constraint(equalToConstant: Constants.sizeProfilePhoto.height/4.5),
            icon.heightAnchor.constraint(equalToConstant: Constants.sizeProfilePhoto.height/4.5),
            stackIconTextView.bottomAnchor.constraint(equalTo: stackInfoView.bottomAnchor)
        ])
    }
    
    //----------------------------------------------------------//
    
    
    //---------------------STACK_BUTTONS------------------------//
    var stackButtonsView = UIStackView()
    
    func setUpStackButtonsView() {
        stackButtonsView.axis = NSLayoutConstraint.Axis.horizontal
        stackButtonsView.distribution = UIStackView.Distribution.fillEqually
        stackButtonsView.alignment = UIStackView.Alignment.center
        stackButtonsView.isLayoutMarginsRelativeArrangement = true
        stackButtonsView.spacing = Constants.spacingStackView
        stackButtonsView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addStackButtonsViewSubviews() {
        view.addSubview(stackButtonsView)
        if let button = messageButton {stackButtonsView.addArrangedSubview(button)}
        if let button = callButton {stackButtonsView.addArrangedSubview(button)}
    }
    
    func layoutStackButtonsView() {
        NSLayoutConstraint.activate([
            stackButtonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackButtonsView.centerYAnchor.constraint(equalTo: view.topAnchor, constant: Constants.topStackView),
            stackButtonsView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -35)
        ])
    }
    //----------------------------------------------------------//
    
    
    //---------------------STACK_INFO---------------------------//
    var stackInfoView = UIStackView()
    
    func setUpStackInfoView() {
        stackInfoView.axis = NSLayoutConstraint.Axis.vertical
        stackInfoView.distribution = UIStackView.Distribution.equalSpacing
        stackInfoView.isLayoutMarginsRelativeArrangement = true
        stackInfoView.spacing = 7
        stackInfoView.translatesAutoresizingMaskIntoConstraints = false
    }
        
    func addStackInfoViewSubviews() {
        view.addSubview(stackInfoView)
        stackInfoView.addArrangedSubview(name)
        stackInfoView.addArrangedSubview(status)
        stackInfoView.addArrangedSubview(stackIconTextView)
    }
    
    func layoutStackInfoView() {
        NSLayoutConstraint.activate([
            stackInfoView.leftAnchor.constraint(equalTo: profilePhoto.rightAnchor, constant: 15),
            stackInfoView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -35),
            stackInfoView.bottomAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: -15)
        ])
        layoutStackIconTextView()
    }
    
    //----------------------------------------------------------//
    
    
    //----------------------TEXTS_PROFILE------------------------//
    var name = UILabel()
    var status = UILabel()
    var moreInfomation = UILabel()
    let icon = UIImageView(image: UIImage(named: "Icon"))
    //let myImage = UIImage(named: "Icon")
    //let stringWithImage = NSMutableAttributedString(string: "Completed!")
    
    func setUpTextsProfile() {
        name.text = "Чичи Александровна"
        name.textAlignment = .left
        name.textColor = .black
        name.font = UIFont.boldSystemFont(ofSize: 20)
        
        status.text = "Собачка Чихуахуа"
        status.textAlignment = .left
        status.textColor = .gray
        status.font = UIFont.systemFont(ofSize: 14)
        
        moreInfomation.text = "Подробная информация"
        moreInfomation.textAlignment = .left
        moreInfomation.textColor = .black
        moreInfomation.font = UIFont.systemFont(ofSize: 15)
        //moreInfomation.addSubview(icon)
        
        //imageView.image = imageView.image!.withRenderingMode(.alwaysTemplate)
        //imageView.tintColor = UIColor.systemBlue
        //self.navigationItem.titleView = imageView
        
        icon.image?.withTintColor(.systemBlue)
        icon.contentMode = .scaleAspectFit
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = .systemTeal
        icon.clipsToBounds = true
        //icon.stackInfoView = .spacingUseSystem
        
    }
    
    //----------------------------------------------------------//
    
    
}

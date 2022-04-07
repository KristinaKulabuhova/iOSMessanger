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
        layoutCollection.minimumInteritemSpacing = 2
        photosCollection?.contentMode = .scaleAspectFill
        layoutCollection.estimatedItemSize = CGSize(width: Constants.sizeProfilePhoto.height * 3/4, height: Constants.sizeProfilePhoto.height * 3/4)
        layoutCollection.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
        return CGSize(width: view.frame.size.width, height: 100)
    }
    
    func layoutPhotosCollectionView() {
        if let collection = photosCollection {
            NSLayoutConstraint.activate([
                collection.topAnchor.constraint(equalTo: photosButton.bottomAnchor, constant: 15),
                collection.leftAnchor.constraint(equalTo: stackButtonsView.leftAnchor),
                collection.heightAnchor.constraint(equalToConstant: 80),
                collection.rightAnchor.constraint(equalTo: stackButtonsView.rightAnchor)
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
        setUpStackStaticticView()
        setUpPhotosButton()
        setUpStackHeaderView()
        
        addStackButtonsViewSubviews()
        addStackInfoViewSubviews()
        addStackIconTextViewSubviews()
        addStackStaticticViewSubviews()
        addPhotosButtonSubviews()
        addStackHeaderViewSubviews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutStackButtonsView()
        layoutStackInfoView()
        layoutPhotosCollectionView()
        layoutProfilePhoto()
        layoutStackStaticticView()
        layoutPhotosButtonView()
        layoutStackHeaderView()
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
//            profilePhoto.bottomAnchor.constraint(equalTo: self.view.topAnchor, constant: Constants.topStackView - 40),
            profilePhoto.heightAnchor.constraint(equalToConstant: Constants.sizeProfilePhoto.height),
            profilePhoto.widthAnchor.constraint(equalToConstant: Constants.sizeProfilePhoto.width),
            profilePhoto.topAnchor.constraint(equalTo: stackHeaderView.bottomAnchor, constant: 20)
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
    }
        
    func addStackIconTextViewSubviews() {
        stackIconTextView.addArrangedSubview(icon)
        stackIconTextView.addArrangedSubview(moreInfomation)
    }
    
    func layoutStackIconTextView() {
        NSLayoutConstraint.activate([
            stackIconTextView.leftAnchor.constraint(equalTo: stackInfoView.leftAnchor),
            stackIconTextView.bottomAnchor.constraint(equalTo: stackInfoView.bottomAnchor),
            icon.widthAnchor.constraint(equalToConstant: Constants.sizeProfilePhoto.height / 4.5),
            icon.heightAnchor.constraint(equalToConstant: Constants.sizeProfilePhoto.height / 4.5)
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
            stackButtonsView.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 10),
            stackButtonsView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -35),
            stackButtonsView.heightAnchor.constraint(equalToConstant: 40)
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
            stackInfoView.leftAnchor.constraint(equalTo: profilePhoto.rightAnchor, constant: 20),
            stackInfoView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -35),
            stackInfoView.bottomAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: -15)
        ])
        layoutStackIconTextView()
    }
    
    //----------------------------------------------------------//
    
    
    //---------------------STACK_STATISTIC---------------------------//
    var stackStatisticView = UIStackView()
    var countSublications = 1440
    var countSubscriptions = 486
    var countSubscribers = 161
    let textSublication = UITextView()
    let textSubscriptions = UITextView()
    let textSubscribers = UITextView()
    
    
    func setUpTextView(text: UITextView, color: UIColor, subtext: String, count: Int) {
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        text.textColor = color
        text.text = "\(count) \(subtext)"
        text.font = UIFont.systemFont(ofSize: 15)
        text.textContainerInset = UIEdgeInsets(top: 25, left: 0, bottom: 12, right: 0)
        text.isScrollEnabled = false
        text.isEditable = false
    }
    
    func setUpStackStaticticView() {
        
        setUpTextView(text: textSublication, color: .systemTeal, subtext: "\n публикаций", count: countSublications)
        setUpTextView(text: textSubscriptions, color: .black, subtext: "\n подписок", count: countSubscriptions)
        setUpTextView(text: textSubscribers, color: .black, subtext: "тыс. \n подписчиков", count: countSubscribers)
        
        stackStatisticView.axis = NSLayoutConstraint.Axis.horizontal
        stackStatisticView.distribution = UIStackView.Distribution.equalSpacing
        stackStatisticView.isLayoutMarginsRelativeArrangement = true
        stackStatisticView.spacing = 3
        stackStatisticView.translatesAutoresizingMaskIntoConstraints = false
    }
        
    func addStackStaticticViewSubviews() {
        view.addSubview(stackStatisticView)
        stackStatisticView.addArrangedSubview(textSublication)
        stackStatisticView.addArrangedSubview(textSubscriptions)
        stackStatisticView.addArrangedSubview(textSubscribers)
    }
    
    func addTopAndBottomBorders() {
        let topBorder = CALayer()
        let bottomBorder = CALayer()
        topBorder.frame = CGRect(x: 0.0, y: 0.0, width: self.stackStatisticView.frame.size.width, height: 1)
        topBorder.backgroundColor = UIColor.systemGray3.cgColor
        bottomBorder.frame = CGRect(x:0, y: self.stackStatisticView.frame.size.height - 1, width: self.stackStatisticView.frame.size.width, height:1)
        bottomBorder.backgroundColor = UIColor.systemGray3.cgColor
        stackStatisticView.layer.addSublayer(topBorder)
        stackStatisticView.layer.addSublayer(bottomBorder)
    }
    
    func layoutStackStaticticView() {
        addTopAndBottomBorders()
        NSLayoutConstraint.activate([
            stackStatisticView.heightAnchor.constraint(equalToConstant: 80),
            stackStatisticView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackStatisticView.topAnchor.constraint(equalTo: stackButtonsView.bottomAnchor, constant: 20),
            stackStatisticView.widthAnchor.constraint(equalTo: stackButtonsView.widthAnchor, constant: -20)
        ])
    }
    //----------------------------------------------------------//
    
    
    //----------------------TEXTS_PROFILE------------------------//
    var name = UILabel()
    var status = UILabel()
    var moreInfomation = UILabel()
    let icon = UIImageView(image: UIImage(named: "Icon"))
    
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
        
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = .systemTeal
    }
    
    //----------------------------------------------------------//
    
    
    //-----------------------BUTTON_PHOTOS----------------------//
    let photosButton = UIButton(type: .system)
    let countPhoto = 10
    let countPhotosStr = UITextView()
    let iconMorePhotos = UIImageView(image: UIImage(named: "MorePhotos"))
    let textPhoto = UILabel()
    
    func setUpPhotosButton() {
        
        textPhoto.translatesAutoresizingMaskIntoConstraints = false
        photosButton.translatesAutoresizingMaskIntoConstraints = false
        textPhoto.textColor = .black
        textPhoto.text = "Фотографии "
        textPhoto.font = .boldSystemFont(ofSize: 16)
        textPhoto.textAlignment = .center
        textPhoto.contentMode = .scaleAspectFit
        countPhotosStr.text = "\(countPhoto)"
        
        let countAttribute = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.systemTeal]
        let countAttrString = NSAttributedString(string: countPhotosStr.text, attributes: countAttribute)
        countPhotosStr.attributedText = countAttrString
        
        let textAttribute = [ NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 19.0), NSAttributedString.Key.foregroundColor: UIColor.black]
        let textAttrString = NSAttributedString(string: textPhoto.text!, attributes: textAttribute as [NSAttributedString.Key : Any])
        textPhoto.attributedText = textAttrString

        let leftCopy = NSMutableAttributedString(attributedString: textPhoto.attributedText!)
        leftCopy.append(countPhotosStr.attributedText!)
        textPhoto.attributedText = leftCopy
        
        photosButton.contentVerticalAlignment = .center
        iconMorePhotos.translatesAutoresizingMaskIntoConstraints = false
        iconMorePhotos.image = iconMorePhotos.image?.withRenderingMode(.alwaysTemplate)
        iconMorePhotos.tintColor = .systemTeal
        iconMorePhotos.contentMode = .scaleToFill
    }
    
    func addPhotosButtonSubviews() {
        view.addSubview(photosButton)
        photosButton.addSubview(iconMorePhotos)
        photosButton.addSubview(textPhoto)
    }
    
    func layoutPhotosButtonView() {
        NSLayoutConstraint.activate([
            photosButton.leftAnchor.constraint(equalTo: stackButtonsView.leftAnchor),
            photosButton.widthAnchor.constraint(equalTo: stackButtonsView.widthAnchor),
            photosButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photosButton.heightAnchor.constraint(equalToConstant: 20),
            textPhoto.topAnchor.constraint(equalTo: photosButton.topAnchor),
            iconMorePhotos.widthAnchor.constraint(equalToConstant: 20),
            iconMorePhotos.heightAnchor.constraint(equalToConstant: 20),
            iconMorePhotos.bottomAnchor.constraint(equalTo: photosButton.bottomAnchor, constant: 0),
            iconMorePhotos.rightAnchor.constraint(equalTo: photosButton.rightAnchor),
            photosButton.topAnchor.constraint(equalTo: stackStatisticView.bottomAnchor, constant: 25)
        ])
    }
    
    //----------------------------------------------------------//
    
    //---------------------STACK_HEADER_TEXT---------------------------//
    var stackHeaderView = UIStackView()
    let menuDots = UIImageView(image: UIImage(named: "MenuDots"))
    let arrowLeft = UIImageView(image: UIImage(named: "ArrowLeft"))
    let urlText = UILabel()
    
    func setUpStackHeaderView() {
        stackHeaderView.axis = NSLayoutConstraint.Axis.horizontal
        stackHeaderView.distribution = UIStackView.Distribution.fillProportionally
        urlText.text = "chi-chi.dog"
        urlText.font = UIFont.systemFont(ofSize: 16)
        urlText.textColor = .black
        //stackHeaderView.alignment = UIStackView.Alignment.leading
        //stackHeaderView.isLayoutMarginsRelativeArrangement = true
        stackHeaderView.spacing = 7
        stackHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        arrowLeft.image = arrowLeft.image?.withRenderingMode(.alwaysTemplate)
        arrowLeft.tintColor = .systemTeal
        menuDots.image = menuDots.image?.withRenderingMode(.alwaysTemplate)
        menuDots.tintColor = .systemTeal
        arrowLeft.translatesAutoresizingMaskIntoConstraints = false
        menuDots.translatesAutoresizingMaskIntoConstraints = false
        menuDots.contentMode = .scaleAspectFit
        arrowLeft.contentMode = .scaleAspectFit
        arrowLeft.focusGroupPriority = .prioritized
        menuDots.focusGroupPriority = .prioritized
        urlText.focusGroupPriority = .ignored
    }
        
    func addStackHeaderViewSubviews() {
        view.addSubview(stackHeaderView)
        stackHeaderView.addArrangedSubview(arrowLeft)
        stackHeaderView.addArrangedSubview(urlText)
        stackHeaderView.addArrangedSubview(menuDots)
    }
    
    func layoutStackHeaderView() {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x:0, y: self.stackHeaderView.frame.size.height - 1, width: self.stackHeaderView.frame.size.width, height:1)
        bottomBorder.backgroundColor = UIColor.systemGray3.cgColor
        stackHeaderView.layer.addSublayer(bottomBorder)
        
        NSLayoutConstraint.activate([
            stackHeaderView.leftAnchor.constraint(equalTo: stackStatisticView.leftAnchor),
            stackHeaderView.widthAnchor.constraint(equalTo: stackStatisticView.widthAnchor),
            stackHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackHeaderView.heightAnchor.constraint(equalToConstant: 40),
            menuDots.widthAnchor.constraint(equalToConstant: 20),
            menuDots.heightAnchor.constraint(equalToConstant: 20),
            arrowLeft.widthAnchor.constraint(equalToConstant: 25),
            arrowLeft.heightAnchor.constraint(equalToConstant: 20),
            arrowLeft.leftAnchor.constraint(equalTo: stackHeaderView.leftAnchor),
            menuDots.rightAnchor.constraint(equalTo: stackHeaderView.rightAnchor),
            urlText.leftAnchor.constraint(equalTo: arrowLeft.rightAnchor, constant: 20)
            //arrowLeft.bottomAnchor.

            //arrowLeft.leftAnchor.constraint(equalTo: stackStatisticView.leftAnchor),
            //menuDots.rightAnchor.constraint(equalTo: stackStatisticView.rightAnchor),
            //menuDots.widthAnchor.constraint(equalToConstant: 20),
            //menuDots.heightAnchor.constraint(equalToConstant: 20),
            //arrowLeft.widthAnchor.constraint(equalToConstant: 20),
            //arrowLeft.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    //----------------------------------------------------------//
}

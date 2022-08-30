//
//  MainCharacteristicsTableViewCell.swift
//  Rocket
//
//  Created by mac on 27.08.2022.
//

import UIKit



class MainCharacteristicsTableViewCell: UITableViewCell {

        //MARK: - Static
    static let identifier = "MainCharacteristicsTableViewCell"
    
        //MARK: - Properties
    var rocket: Rocket?
    
    var mainCharacteristics = [MainCharacteristics]()
    

        //MARK: - Views
    
    private let mainCharacteristicsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MainCharacteristicsCollectionViewCell.self, forCellWithReuseIdentifier: MainCharacteristicsCollectionViewCell.identifier)
        return collectionView
    }()
    
    
        //MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(mainCharacteristicsCollectionView)
        mainCharacteristicsCollectionView.delegate = self
        mainCharacteristicsCollectionView.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        //MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        mainCharacteristicsCollectionView.frame = contentView.bounds
    }
    
    func configureCell(mainCharacteristics: [MainCharacteristics]) {
        self.mainCharacteristics = mainCharacteristics
        mainCharacteristicsCollectionView.reloadData()
    }
    

}


extension MainCharacteristicsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mainCharacteristics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let mainCharacteristic = mainCharacteristics[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCharacteristicsCollectionViewCell.identifier, for: indexPath) as! MainCharacteristicsCollectionViewCell
        
        
        
        cell.configure(with: mainCharacteristic)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width, height: 200)
    }
    
}

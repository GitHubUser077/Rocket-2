//
//  MainCharacteristicsCollectionViewCell.swift
//  Rocket
//
//  Created by mac on 31.08.2022.
//

import UIKit

class MainCharacteristicsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MainCharacteristicsCollectionViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(nameLabel)
        contentView.addSubview(valueLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 5, y: 5, width: contentView.frame.size.width-10, height: (contentView.frame.size.height)/2 - 5 )
        valueLabel.frame = CGRect(x: 5, y: nameLabel.frame.size.height+5, width: contentView.frame.size.width-10, height: (contentView.frame.size.height)/2 - 5)
    }
    
    func configure(with mainCharacteristics: MainCharacteristics) {
        print("\(mainCharacteristics.name) [] [] [] \(mainCharacteristics.value)")
        nameLabel.text = mainCharacteristics.name
        valueLabel.text = mainCharacteristics.value
    }
    
}

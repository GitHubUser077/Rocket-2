//
//  GeneralInfoTableViewCell.swift
//  Rocket
//
//  Created by mac on 31.08.2022.
//

import UIKit

class GeneralInfoTableViewCell: UITableViewCell {

    static let identifier = "GeneralInfoTableViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = .green
        label.textAlignment = .right
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(valueLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 10, y: 10, width: (contentView.frame.size.width)/2 - 40, height: contentView.frame.size.height - 20)
        valueLabel.frame = CGRect(x: nameLabel.frame.width + 10, y: 10, width: (contentView.frame.size.width)/2 + 20, height: contentView.frame.size.height - 20)
    }
    
    func configure(with viewModel: GeneralInfo) {
        nameLabel.text = viewModel.name
        valueLabel.text = viewModel.value
    }
    
}

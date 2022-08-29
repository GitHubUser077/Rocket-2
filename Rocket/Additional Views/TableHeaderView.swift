//
//  TableHeaderView.swift
//  Rocket
//
//  Created by mac on 23.08.2022.
//

import UIKit

class TableHeaderView: UIView {

    let label: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Falcon Heave"
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var image = UIImage(systemName: "gear")
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.imageView?.tintColor = .label
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addSubview(label)
        addSubview(button)
        

        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            button.widthAnchor.constraint(equalToConstant: 30),
            button.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

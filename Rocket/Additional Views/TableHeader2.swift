//
//  TableHeader2.swift
//  Rocket
//
//  Created by mac on 02.09.2022.
//

import UIKit

//
//  TableHeaderView.swift
//  Rocket
//
//  Created by mac on 23.08.2022.
//

import UIKit

class TableHeader2: UIView {
    
 
    

    
    let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    let uiView: UIView = {
        let uiView = UIView()
        uiView.layer.cornerRadius = 25
        uiView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        uiView.backgroundColor = .orange
        return uiView
    }()

    let label: UILabel = {
       let label = UILabel()
        
        label.text = "Falcon Heave"
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        
        var image = UIImage(systemName: "gear")
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.imageView?.tintColor = .label
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        
        addSubview(imageView)
        addSubview(uiView)
        uiView.addSubview(label)
        uiView.addSubview(button)
       
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        //500
        imageView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 200)
        uiView.frame = CGRect(x: 0, y: imageView.frame.size.height-30, width: self.frame.size.width, height: 90)
    }
    
    
}


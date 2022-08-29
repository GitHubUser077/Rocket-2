//
//  MainCharacteristicsTableViewCell.swift
//  Rocket
//
//  Created by mac on 27.08.2022.
//

import UIKit

struct MainCharacteristics {

    let height: Diameter
    let diameter: Diameter
    let mass: Mass
    let id: String

    init(rocket: Rocket) {
        self.height = rocket.height
        self.diameter = rocket.diameter
        self.mass = rocket.mass
        self.id = rocket.id
    }

}

struct Metrics {
    
}

class MainCharacteristicsTableViewCell: UITableViewCell {

        //MARK: - Static
    static let identifier = "MainCharacteristicsTableViewCell"
    
        //MARK: - Properties
    var rocket: Rocket?
    
    var mainCharacteristics: MainCharacteristics?
    
    var metrics = [Metrics]()
    
        //MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        //MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureCell(rocket: Rocket) {
        mainCharacteristics = MainCharacteristics(rocket: rocket)
    }
    

}

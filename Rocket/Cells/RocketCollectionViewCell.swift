//
//  RocketCollectionViewCell.swift
//  Rocket
//
//  Created by mac on 23.08.2022.
//

import UIKit




enum SectionType {
    case characteristics(rocketModel: Rocket?)
    case test
}

class RocketCollectionViewCell: UICollectionViewCell {
    
        //MARK: - Static
    static let identifier = "RocketCollectionViewCell"
    
        //MARK: - Views
    let rocketTableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
        let header = TableHeaderView()
        header.frame = CGRect(x: 0, y: 0, width: table.frame.width, height: 100)
        header.label.text = "Heavy Falcon"
        table.tableHeaderView = header
        return table
    }()
    
        //MARK: - Properties/Dependencies
    
    var rocket: Rocket?
    
    
    var sections = [SectionType]()

  
    
    
        //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        configureTableView()
        contentView.addSubview(rocketTableView)
        rocketTableView.delegate = self
        rocketTableView.dataSource = self
       
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rocketTableView.frame = contentView.bounds
    }
    
    
    
    func configureTableView() {
        print("----------just some print ----------")
        self.sections.append(.characteristics(rocketModel: rocket))
        self.sections.append(.test)
        print("configureTableView \(sections.count)")
    }
    
}


    //MARK: -  TableView Methods

extension RocketCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("Number of sections: \(sections.count)")
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        
        switch sectionType {
        
        case .characteristics:
            return 1
        case .test:
            return 3
        }

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionType = sections[section]
        guard let unwrappedRocket = rocket else { return nil }
        switch sectionType {
        case .characteristics:
            return nil
        case .test:
            return "Test \(unwrappedRocket.name)"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionType = sections[section]
        switch sectionType {
        case .characteristics:
            return 0
        case .test:
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let rocket = rocket else { return UITableViewCell() }
        let sectionType = sections[indexPath.section]
        
        // Fix the shit below
        switch sectionType {
        
        case .characteristics:
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
            
            cell.textLabel?.text = "hello"
            
            return cell
        case .test:
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
            
            cell.textLabel?.text = "hello \(rocket.name)"
            
            return cell
        }
        
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
//        
//        cell.textLabel?.text = "hello"
//        
//        return cell
    }
    
    
}

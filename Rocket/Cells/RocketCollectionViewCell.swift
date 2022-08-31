//
//  RocketCollectionViewCell.swift
//  Rocket
//
//  Created by mac on 23.08.2022.
//

import UIKit



struct MainCharacteristics {
    let name: String
    let value: String
}

struct GeneralInfo {
    let name: String
    let value: String
}

enum SectionType {
    case characteristics(rocketModel: [MainCharacteristics])
    case generalInformation(generalInfoViewModels: [GeneralInfo])
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
        header.frame = CGRect(x: 0, y: 0, width: table.frame.width, height: 60)
        header.label.text = "Heavy Falcon"
        table.tableHeaderView = header
        return table
    }()
    
        //MARK: - Properties/Dependencies
    
    var rocket: Rocket? {
        didSet {
            configureTableView()
        }
    }
    
    
    var sections = [SectionType]()

  
    
    
        //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
//        configureTableView()
        contentView.addSubview(rocketTableView)
        registerCells()
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
    
    
        //MARK: - Configuration
    func configureTableView() {
        
 
        guard let unwrappedRocket = rocket else { return }
       //mainCharacteristics
        let mainCharacteristics: [MainCharacteristics] = [
            .init(name: "Height", value: "\(String(describing: unwrappedRocket.height.meters))"),
            .init(name: "Diameter", value: "\(String(describing: unwrappedRocket.diameter.meters))"),
            .init(name: "Mass", value: "\(unwrappedRocket.mass.kg)")
        ]
        
        self.sections.append(.characteristics(rocketModel: mainCharacteristics))
        
        //generalInfo
        let generalInfo: [GeneralInfo] = [
            .init(name: "First flight", value: "\(unwrappedRocket.firstFlight)"),
            .init(name: "Country", value: "\(unwrappedRocket.country)"),
            .init(name: "Cost per launch", value: "\(unwrappedRocket.costPerLaunch)")
        ]
        self.sections.append(.generalInformation(generalInfoViewModels: generalInfo))
        
        //test
        self.sections.append(.test)
        print("configureTableView \(sections.count)")
    }
    
    func registerCells() {
        rocketTableView.register(MainCharacteristicsTableViewCell.self, forCellReuseIdentifier: MainCharacteristicsTableViewCell.identifier)
        rocketTableView.register(GeneralInfoTableViewCell.self, forCellReuseIdentifier: GeneralInfoTableViewCell.identifier)
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
        case .generalInformation(let viewModels):
            return viewModels.count
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
        case .generalInformation:
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
        case .generalInformation:
            return 0
        case .test:
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let rocket = rocket else { return UITableViewCell() }
        let sectionType = sections[indexPath.section]
        
        switch sectionType {
        case .characteristics(let mainCharacteristics):
            let cell = tableView.dequeueReusableCell(withIdentifier: MainCharacteristicsTableViewCell.identifier, for: indexPath) as! MainCharacteristicsTableViewCell
            
            print("{}{}{}{}\(mainCharacteristics.count)")
           
            cell.configureCell(mainCharacteristics: mainCharacteristics)

            return cell
            
            
            
        case .generalInformation(let viewModels):
            
            let generalInfo = viewModels[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: GeneralInfoTableViewCell.identifier, for: indexPath) as! GeneralInfoTableViewCell
            
            cell.configure(with: generalInfo)
            
            return UITableViewCell()
            
            
            
            
            
        case .test:
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
            
            cell.textLabel?.text = "hello \(rocket.name)"
            print("******tableViewCell***unwrappedRocket = \(rocket.name)")
            
            return cell
        }
        

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .characteristics:
            return 100
        case .generalInformation:
            return 50
        case .test:
            return UITableView.automaticDimension
        }
    }
    
}

//
//  RocketCollectionViewCell.swift
//  Rocket
//
//  Created by mac on 23.08.2022.
//

import UIKit

protocol NameValueTableViewCell {
    var name: String { get }
    var value: String { get }
}

struct MainCharacteristics {
    let name: String
    let value: String
}

struct GeneralInfo: NameValueTableViewCell {
    let name: String
    let value: String
}

struct FirstStageViewModel: NameValueTableViewCell {
    let name: String
    let value: String
}

struct SecondStageViewModel: NameValueTableViewCell {
    let name: String
    let value: String
}

enum SectionType {
    case characteristics(rocketModel: [MainCharacteristics])
    case generalInformation(generalInfoViewModels: [GeneralInfo])
    case firstStage(firstStageViewModel: [FirstStageViewModel])
    case secondStage(firstStageViewModel: [SecondStageViewModel])
}

class RocketCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Static
    static let identifier = "RocketCollectionViewCell"
    
    //MARK: - Views
    
//    let rocketImageView: UIImageView = {
//       let imageView = UIImageView()
//        
//        return imageView
//    }()
    
    let topView = TableHeader2()
    
    let rocketTableView: UITableView = {
        let table = UITableView()
        table.allowsSelection = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
//        let header = TableHeaderView()
//        let header = TableHeader2()
//        header.frame = CGRect(x: 0, y: 0, width: table.frame.width, height: 260)
//        header.label.text = "Heavy Falcon"
//        table.tableHeaderView = header
//        table.tableHeaderView = header
        return table
    }()
    
    //MARK: - Properties/Dependencies
    
    var rocket: Rocket? {
        didSet {
            setImage()
            configureTableView()
        }
    }
    
    
    var sections = [SectionType]()
    
    
    
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        //        configureTableView()
//        contentView.addSubview(rocketImageView)
        contentView.addSubview(topView)
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
//        rocketImageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.height/3)
        
//        rocketTableView.frame = contentView.bounds
//        rocketTableView.frame = CGRect(x: 0, y: rocketImageView.frame.size.height-20, width: contentView.frame.size.width, height: (((contentView.frame.size.height)/3)*2)+20 )
        
        
        topView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: 260)
        rocketTableView.frame = CGRect(x: 0, y: topView.frame.size.height, width: contentView.frame.size.width, height: contentView.frame.size.height-topView.frame.size.height)
        
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
        
        
        //FirstStage
        let firstStageViewModels: [FirstStageViewModel] = [
            .init(name: "Number of engines", value: "\(unwrappedRocket.firstStage.engines)"),
            .init(name: "Fuel Amount Tons", value: "\(unwrappedRocket.firstStage.fuelAmountTons)"),
            .init(name: "Burn time SECTons", value: "\(String(describing: unwrappedRocket.firstStage.burnTimeSEC))")
            
        ]
        
        self.sections.append(.firstStage(firstStageViewModel: firstStageViewModels))
        
        // SecondStage
        let secondStageViewModels: [SecondStageViewModel] = [
            .init(name: "Number of engines", value: "\(unwrappedRocket.secondStage.engines)"),
            .init(name: "Fuel Amount", value: "\(unwrappedRocket.secondStage.fuelAmountTons)"),
            .init(name: "Burn time SECTons", value: "\(String(describing: unwrappedRocket.secondStage.burnTimeSEC))")
        ]
        
        self.sections.append(.secondStage(firstStageViewModel: secondStageViewModels))
        
    }
    
    func registerCells() {
        rocketTableView.register(MainCharacteristicsTableViewCell.self, forCellReuseIdentifier: MainCharacteristicsTableViewCell.identifier)
        rocketTableView.register(GeneralInfoTableViewCell.self, forCellReuseIdentifier: GeneralInfoTableViewCell.identifier)
        
    }
    
    func setImage() {
        guard let unwrappedRocket = rocket else { return }
        let images = unwrappedRocket.flickrImages
       
//        rocketImageView.image = UIImage(named: "rocket")
        
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
        case .firstStage(let viewModels):
            return viewModels.count
        case .secondStage(let viewModels):
            return viewModels.count
            
            
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
        case .firstStage:
            return "First Stage"
        case .secondStage:
            return "Second Stage"
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionType = sections[section]
        switch sectionType {
        case .characteristics:
            return 0
        case .generalInformation:
            return 0
        case .firstStage:
            return 30
        case .secondStage:
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        guard let rocket = rocket else { return UITableViewCell() }
        let sectionType = sections[indexPath.section]
        
        switch sectionType {
        case .characteristics(let mainCharacteristics):
            let cell = tableView.dequeueReusableCell(withIdentifier: MainCharacteristicsTableViewCell.identifier, for: indexPath) as! MainCharacteristicsTableViewCell
            
            cell.configureCell(mainCharacteristics: mainCharacteristics)
            
            return cell
            
        case .generalInformation(let viewModels):
            
            let generalInfo = viewModels[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: GeneralInfoTableViewCell.identifier, for: indexPath) as! GeneralInfoTableViewCell
            
            cell.configure(with: generalInfo)
            
            return UITableViewCell()
            
        case .firstStage(let viewModels):
            
            let firstStageViewModel = viewModels[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: GeneralInfoTableViewCell.identifier, for: indexPath) as! GeneralInfoTableViewCell
            
            cell.configure(with: firstStageViewModel)
            
            
            return cell
            
            
            
            
        case .secondStage(let viewModels):
            
            let firstViewModel = viewModels[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: GeneralInfoTableViewCell.identifier, for: indexPath) as! GeneralInfoTableViewCell
            
            cell.configure(with: firstViewModel)
            
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
        case .firstStage:
            return 50
        case .secondStage:
            return 50
        }
    }
    
}



//
//  ViewController.swift
//  Rocket
//
//  Created by mac on 22.08.2022.
//

import UIKit
import FloatingPanel

class RocketViewController: UIViewController {
    
    
        //MARK: - Views
    private var pagingCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    
        //MARK: - Properties
    
    var rockets: [Rocket] = []

    
        //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpPagingCollectionView()
        
        view.backgroundColor = .systemBackground
        
        APICaller.shared.cosmicRocket { [weak self] rockets  in
            for rocket in rockets {
                print("\(rocket.name)")
                
//                print("\(rocket.height)")
                var height = rocket.height
                print("\(height.meters)")
                
                
            }
            
            DispatchQueue.main.async {
                self?.rockets = rockets
                self?.pagingCollectionView.reloadData()
            }
            
        }
        
     
    }
    
  
    
    func setUpPagingCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        
        pagingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        pagingCollectionView.frame = view.bounds
        pagingCollectionView.register(RocketCollectionViewCell.self, forCellWithReuseIdentifier: RocketCollectionViewCell.identifier)
        
        pagingCollectionView.delegate = self
        pagingCollectionView.dataSource = self
        
        view.addSubview(pagingCollectionView)
    

    }
    

}



extension RocketViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rockets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketCollectionViewCell.identifier, for: indexPath) as! RocketCollectionViewCell
        
        cell.backgroundColor = [UIColor.red, UIColor.green, UIColor.blue, UIColor.orange].randomElement()
        
        cell.rocket = rockets[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height)
    }
    
}

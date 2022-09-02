//
//  APICaller.swift
//  Rocket
//
//  Created by mac on 22.08.2022.
//

import Foundation

// Космические ракеты - https://api.spacexdata.com/v4/rockets

class APICaller {
    static let shared = APICaller()
    
    private init() { }
    
    //test call function
    
    func cosmicRocket(completion: @escaping ([Rocket]) -> Void) {
        
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets") else {
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                completion([])
                return
            }
            
            do {
                let result = try JSONDecoder().decode([Rocket].self, from: data)
                completion(result)
            } catch {
                print(error)
            }
            
        }
        
        task.resume()
        
    }
    
    func fetchImage(imageUrlString: String, completion: @escaping (Data?) -> Void) {
       
        guard let url = URL(string: imageUrlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else  {
                completion(nil)
                return
            }
            
           completion(data)
        }
        task.resume()
        
    }
    
}

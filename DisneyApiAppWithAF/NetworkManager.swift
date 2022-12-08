//
//  NetworkManager.swift
//  DisneyApiAppWithAF
//
//  Created by Denis Kukushkin on 08.12.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchData (from url: String?, with completion: @escaping(Disney) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print (error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let hero = try JSONDecoder().decode(Disney.self, from: data)
                DispatchQueue.main.async {
                    completion(hero)
                }
            }
            
            catch let error {
                print (error)
            }
        } .resume()
    }
}
        
class ImageManager {
    
    static let shared = ImageManager()
    private init() {}
    
    func fetchImage(from url: String?) -> Data? {
        guard let stringURL = url else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil }
        return try? Data(contentsOf: imageURL)
        
    }
    
}

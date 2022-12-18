//
//  NetworkManager.swift
//  DisneyApiAppWithAF
//
//  Created by Denis Kukushkin on 08.12.2022.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    
    func fetchData (from url: String, completion: @escaping(Result<Disney, NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let disney = Disney.getDisney(from: value)
                    DispatchQueue.main.async {
                        completion(.success(disney))
                    }
                case .failure:
                    completion(.failure(.noData))
                }
            }
    }
}
     
class ImageManager {
    
    static let shared = ImageManager()
    private init() {}
    
    func fetchImage(from url: String, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    completion(.success(data))
                case .failure:
                    completion(.failure(.noData))
                }
            }
    }
}


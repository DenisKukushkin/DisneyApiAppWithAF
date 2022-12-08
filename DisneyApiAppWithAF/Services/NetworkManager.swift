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
    
    
    func fetchData (_ url: String, completion: @escaping(Result<Disney, NetworkError>) -> Void) {
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
                    completion(.failure(.decodingError))
                }
            }
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


//
//  NetworkManager.swift
//  n11-case
//
//  Created by simge on 6.11.2024.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
    case unknownError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                if let statusCode = response.response?.statusCode {
                    completion(.failure(NetworkError.serverError(statusCode: statusCode)))
                } else if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                    completion(.failure(NetworkError.noData))
                } else if (error as NSError).code == NSURLErrorCannotDecodeContentData {
                    completion(.failure(NetworkError.decodingError))
                } else {
                    completion(.failure(NetworkError.unknownError))
                }
            }
        }
    }
}



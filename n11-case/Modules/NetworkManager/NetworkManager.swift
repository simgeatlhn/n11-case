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
                    let networkError = error.toNetworkError(statusCode: response.response?.statusCode)
                    completion(.failure(networkError))
                }
            }
    }
}

extension Error {
    func toNetworkError(statusCode: Int? = nil) -> NetworkError {
        if let code = statusCode, !(200...299).contains(code) {
            return .serverError(statusCode: code)
        }
        switch (self as NSError).code {
        case NSURLErrorNotConnectedToInternet:
            return .noData
        case NSURLErrorCannotDecodeContentData:
            return .decodingError
        default:
            return .unknownError
        }
    }
}

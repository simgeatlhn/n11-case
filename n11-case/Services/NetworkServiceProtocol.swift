//
//  NetworkServiceProtocol.swift
//  n11-case
//
//  Created by simge on 8.11.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

extension NetworkManager: NetworkServiceProtocol {}

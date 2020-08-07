//
//  JSONDecoder-Extension.swift
//  Friendface
//
//  Created by Andres Vazquez on 2020-08-07.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case errorFetching, errorDecoding
    
    var errorDescription: String? {
        switch self {
        case .errorFetching:
            return "Error fetching URL"
        case .errorDecoding:
            return "Error decoding JSON"
        }
    }
}

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, fromURL url: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            fatalError("Invalid URL passed.")
        }
        
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do {
                        let decodedData = try self.decode(type, from: data)
                        
                        DispatchQueue.main.async {
                            completion(.success(decodedData))
                        }
                        return
                    } catch {
                        completion(.failure(.errorDecoding))
                    }
                }
                
                completion(.failure(.errorFetching))
            }.resume()
        }
    }
}

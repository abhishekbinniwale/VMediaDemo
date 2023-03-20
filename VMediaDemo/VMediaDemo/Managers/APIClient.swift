//
//  APIClient.swift
//  VMediaDemo
//
//  Created by Abhishek Binniwale on 19/03/23.
//

import Foundation

enum CustomError: Error {
    case invalidUrl
    case invalidData
    case unknown
}

extension CustomError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .invalidData:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
}

// Generic API class to fetch the data from url,
// And do the Json parsing using Codable protocol
class APIClient {
    
    var baseUrl: String
    
    static let shared = { APIClient(baseUrl: APIManager.shared.baseURL) }()
    
    init (baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func getArray<T: Codable>(urlString: String,
                              expecting: T.Type,
                              completion: @escaping (Result<T, Error>) -> ()) {
        
        let urlString = "\(baseUrl)/\(urlString)"
        guard let url = URL(string: urlString) else {
            completion(.failure(CustomError.invalidUrl))
            return
        }

        let request = URLRequest(url: url)
        print(url)
        let task = URLSession.shared.dataTask(with: request) { data, dataResponse, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(expecting, from: data)
                    completion(.success(result))
                } catch let decodeError {
                    print("Decoding error:\(decodeError)")
                    completion(.failure(CustomError.invalidData))
                }
            }
        }
        task.resume()
    }
}

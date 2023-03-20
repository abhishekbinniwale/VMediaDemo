//
//  ChannelListService.swift
//  VMediaDemo
//
//  Created by Abhishek Binniwale on 19/03/23.
//

import Foundation


protocol ChannelListServiceProtocol {
    func getChannels(count: Int, completion: @escaping (Result<[Channel], Error>) -> ())
    func configureApiCall(_ baseURL: String) -> String
}

// API service class for Channels list

class ChannelListService: ChannelListServiceProtocol {
    
    static let shared = { ChannelListService() }()

    
    // TO get the Channels list
    func getChannels(count: Int, completion: @escaping (Result<[Channel], Error>) -> ()) {
        
        let urlString = self.configureApiCall(Endpoints.channels)
        
        APIClient.shared.getArray(urlString: urlString, expecting: [Channel].self) { result in
            switch result {
            case .success(let channels):
                completion(.success(channels))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Here we can do the API configuration if wants to implement pagination.
    func configureApiCall(_ baseURL: String) -> String {
        return baseURL
    }
}

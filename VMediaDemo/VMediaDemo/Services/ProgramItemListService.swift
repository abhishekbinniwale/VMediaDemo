//
//  ProgramItemListService.swift
//  VMediaDemo
//
//  Created by Abhishek Binniwale on 19/03/23.
//

import Foundation

protocol ProgramItemListServiceProtocol {
    func getProgramItemList(completion: @escaping (Result<[ProgramItem], Error>) -> ())
    func configureApiCall(_ configURL: String) -> String
}

// API service class for province list

class ProgramItemListService: ProgramItemListServiceProtocol {
    
    static let shared = { ProgramItemListService() }()
    
    // TO get the province of country by country code
    func getProgramItemList(completion: @escaping (Result<[ProgramItem], Error>) -> ()) {
        
        let urlString = self.configureApiCall(Endpoints.programItems)
        
        APIClient.shared.getArray(urlString: urlString, expecting: [ProgramItem].self) { result in
            switch result {
            case .success(let provinces):
                completion(.success(provinces))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Here we can do the API configuration if wants to implement pagination.
    func configureApiCall(_ configURL: String) -> String {
        return configURL
    }
}

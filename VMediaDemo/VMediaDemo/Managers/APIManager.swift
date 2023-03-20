//
//  APIManager.swift
//  VMediaDemo
//
//  Created by Abhishek Binniwale on 19/03/23.
//

import Foundation

// API Manager class to manage the API urls
class APIManager {
    
    static let shared = { APIManager() }()
    
    lazy var baseURL: String = {
        return "https://demo-c.cdn.vmedia.ca/json"
    }()
}

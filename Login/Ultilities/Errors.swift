//
//  Errors.swift
//  Login
//
//  Created by Hanh Vo on 6/15/23.
//

import Foundation

enum ApiError: Error {
    case invalidUrl
    case noData
    case networkError(Error)
    case decodingFailed(Error)
    case badStatusCode(Int)
    
    var localizedDescription: String {
        switch self {
        case .invalidUrl:
            return "The provided Url is not valid"
        case .noData:
            return "The request returned no data"
        case .decodingFailed(let error):
            return "Invalid credentials. \(error.localizedDescription)"
        case .networkError(let error):
            return "Possible network error \(error.localizedDescription)"
        case .badStatusCode(let statusCode):
            return "Received unexpected status code: \(statusCode)"
        }
    }
}

enum LoginError: Error {
    case loginInfoEmpty
    case usernameEmpty
    case passwordEmpty
    case apiError(ApiError)
    
    var localizedDescription: String {
        switch self {
        case .loginInfoEmpty:
            return "Username and password are empty."
        case .usernameEmpty:
            return "Username is empty."
        case .passwordEmpty:
            return "Password is empty."
        case .apiError(let error):
            return error.localizedDescription
        }
    }
}

//
//  NetworkService.swift
//  Login
//
//  Created by Hanh Vo on 6/9/23.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    private func makeRequest<EncodedModel: Codable>(with model: EncodedModel, from urlRequest: URL) -> URLRequest {
        var request = URLRequest(url: urlRequest)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(model)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private func validateURL(from urlString: String) -> URL? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
    
    private func decodeData<T: Codable>(from urlRequest: URLRequest, completion: @escaping (Result<T, ApiError>) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(.badStatusCode(httpResponse.statusCode)))
                return
            }
            
            do {
                let responseModel = try JSONDecoder().decode(T.self, from: data)
                completion(.success(responseModel))
            } catch let decodeError {
                completion(.failure(.decodingFailed(decodeError)))
            }
        }.resume()
    }
    

 
    func makeRequestAndFetchData<T: Codable, E: Codable>(with model: T, from urlString: String, completion: @escaping (Result<E, ApiError>) -> Void) {
        guard let url = validateURL(from: urlString) else {
            completion(.failure(.invalidUrl))
            return
        }
        let request = makeRequest(with: model, from: url)
        decodeData(from: request, completion: completion)
    }
    
    func fetchData<T: Codable>(from urlString: String, completion: @escaping (Result<T, ApiError>) -> Void) {
        guard let url = validateURL(from: urlString) else {
            completion(.failure(.invalidUrl))
            return
        }
        let urlRequest = URLRequest(url: url)
        decodeData(from: urlRequest, completion: completion)
    }
    
    func addProduct<T: Codable>(with model: T, from urlString: String, completion: @escaping (Result<T, ApiError>) -> Void){
        guard let url = validateURL(from: urlString) else {
            completion(.failure(.invalidUrl))
            return
        }
        let request = makeRequest(with: model, from: url)
        
        decodeData(from: request, completion: completion)
    }
    
}


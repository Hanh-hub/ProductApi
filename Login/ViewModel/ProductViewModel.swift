//
//  ProductViewModel.swift
//  Login
//
//  Created by Hanh Vo on 6/13/23.
//

import Foundation
import Combine

class ProductListViewModel: ObservableObject {
    @Published var products = [Product]()
    @Published var categories = [String]()
    var searchTask: DispatchWorkItem?
    
    func fetchProducts(completion: @escaping(ApiError?)->Void) {
        NetworkService.shared.fetchData(from: Constant.ApiEndPoint.productApi) { (result: Result<ProductResponse, ApiError>) in
            switch result {
            case .success(let productResponse):
                DispatchQueue.main.async {
                    self.products = productResponse.products
                }
                completion(nil)
                // Notify your view to update here
            case .failure(let error):
                completion(error)
                //self.onErrorHandling?(error)
            }
        }
    }

    
    func fetchProducts(by searchText: String, completion: @escaping(ApiError?)->Void){
        searchTask?.cancel()
        let task = DispatchWorkItem {
            NetworkService.shared.fetchData(from: Constant.ApiEndPoint.productApi + "/search?q=\(searchText)") { (result: Result<ProductResponse, ApiError>) in
                switch result {
                case .success(let productResponse):
                   DispatchQueue.main.async {
                        self.products = productResponse.products
                   }
                    completion(nil)
                case .failure(let apiError):
                    completion(apiError)
                }
            }
        }
        self.searchTask = task
        DispatchQueue.main.asyncAfter(deadline: .now()+0.8, execute: task)
    }
    
    func fetchCategories(completion: @escaping(ApiError?) ->Void){
        NetworkService.shared.fetchData(from: Constant.ApiEndPoint.categoriesApi) { (result: Result<[String], ApiError>) in
            switch result {
            case .success(let categories):
             //   DispatchQueue.main.async {
                    self.categories = categories
                    print(self.categories)
               // }
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    
    func fetchProductByCategory(category: String, completion: @escaping(ApiError?) ->Void){
        NetworkService.shared.fetchData(from: Constant.ApiEndPoint.categoryApi + "\(category)") { (result: Result<ProductResponse, ApiError>) in
            switch result {
            case .success(let productResponse):
               // DispatchQueue.main.async {
                    self.products = productResponse.products
             //   }
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return products.count
    }
    
    func productAtIndex(_ index: Int) -> Product {
        return products[index]
    }
    
    
}

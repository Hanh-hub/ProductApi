//
//  ProductDetailViewModel.swift
//  Login
//
//  Created by Hanh Vo on 6/30/23.
//

import Foundation
import Combine

class ProductDetailViewModel: ObservableObject {
    var cancellable = Set<AnyCancellable>()
    @Published var product: Product?

    func fetchProductDetails(productID: Int, completion: @escaping(ApiError?) -> Void){
        NetworkService.shared.fetchData(from: Constant.ApiEndPoint.productApi + "/\(productID)") { (result:  Result<Product, ApiError>) in
            switch result {
            case .success(let product):
                self.product = product
               // dump(product)
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func setUpSubscriber(completion: @escaping(Product?)->Void){
        $product
            .filter{ $0 != nil }
            .sink { product in
                completion(product)
            }
            .store(in: &cancellable)
        
    }
}


//    func fetchProductDetails(productID: Int, completion: @escaping(Product?, ApiError?) -> Void){
//        NetworkService.shared.fetchData(from: Constant.ApiEndPoint.productApi + "/\(productID)") { (result:  Result<Product, ApiError>) in
//            switch result {
//            case .success(let product):
//                completion(product, nil)
//            case .failure(let error):
//                completion(nil, error)
//            }
//        }
//    }

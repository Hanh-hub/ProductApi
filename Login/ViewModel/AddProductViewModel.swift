//
//  AddProductViewModel.swift
//  Login
//
//  Created by Hanh Vo on 7/5/23.
//

import Foundation


class AddProductViewModel{
    var product: Product?
    
    func addProduct(product: Product, completion: @escaping(ApiError?)-> Void){
        NetworkService.shared.addProduct(with: product, from: Constant.ApiEndPoint.addProductApi){(result: Result<Product, ApiError>) in
            switch result {
            case .success(let response):
                self.product = response
                dump(self.product)
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}



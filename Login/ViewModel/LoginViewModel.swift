//
//  ViewModel.swift
//  Login
//
//  Created by Hanh Vo on 6/9/23.
//

import Foundation
// LoginViewModel.swift
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var username: String = "kminchelle"
    @Published var password: String = "0lelplR"
    @Published var isLoggedIn = false
    @Published var user: UserModel?
    @Published var isLoading = false
    
    private func inputValidate(_ username: String, _ password:String) -> LoginError?{
        let isUsernameEmpty = username.isEmpty
        let isPasswordEmpty = password.isEmpty
        switch (isUsernameEmpty, isPasswordEmpty) {
        case (true, true):
            return .loginInfoEmpty
        case (true, false):
           return .usernameEmpty
        case (false, true):
            return .passwordEmpty
        case (false, false):
            return nil
        }
    }

    func login(completion: @escaping (Result<UserModel, LoginError>) -> Void) {
        isLoading = true
        
        if let loginError = inputValidate(username, password){
            completion(.failure(loginError))
            return
        }

        let loginRequest = LoginRequestModel(username: username, password: password)
        let url = Constant.ApiEndPoint.loginApi
    
        NetworkService.shared.makeRequestAndFetchData(with: loginRequest, from: url) { (result: Result<UserModel, ApiError>) in
            DispatchQueue.main.async {
                self.isLoading.toggle()
                switch result {
                case .success(let userModel):
                    self.isLoggedIn = true
                    UserDefaults.standard.set(userModel.token, forKey: "LoggediInUserData")
                    completion(.success(userModel))
                case .failure(let apiError):
                    print("failedeeee")
                    completion(.failure(.apiError(apiError)))
                }
            }
        }
    }
    
}

//        let isUsernameEmpty = username.isEmpty
//        let isPasswordEmpty = password.isEmpty
//
//        switch (isUsernameEmpty, isPasswordEmpty) {
//        case (true, true):
//            completion(.failure(.loginInfoEmpty))
//            return
//        case (true, false):
//            completion(.failure(.usernameEmpty))
//            return
//        case (false, true):
//            completion(.failure(.passwordEmpty))
//            return
//        case (false, false):
//            break
//        }

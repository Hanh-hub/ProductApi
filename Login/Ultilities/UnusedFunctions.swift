////
////  UnusedFunctions.swift
////  Login
////
////  Created by Hanh Vo on 6/16/23.
////
//
//import Foundation
//
//private func validateInput(){
//    let isUsernameEmpty = usernameTextField.text?.isEmpty ?? true
//    let isPasswordEmpty = passwordTextField.text?.isEmpty ?? true
//
//    switch (isUsernameEmpty, isPasswordEmpty) {
//    case (true, true):
//        presentAlert(message: Constant.LoginError.loginInfoEmpty)
//        return
//    case (true, false):
//        presentAlert(message: Constant.LoginError.usernameEmpty)
//        return
//    case (false, true):
//        presentAlert(message: Constant.LoginError.passwordEmpty)
//        return
//
//    case (false, false):
//        logIn()
//    }
//
//
//    func logIn() {
//        guard let username = usernameTextField.text,
//              let password = passwordTextField.text else {
//            return
//        }
//
//        activityIndicator.isHidden = false
//        viewModel.login(withUsername: username, password: password) { [weak self] result in
//            DispatchQueue.main.async {
//                self?.activityIndicator.isHidden = true
//
//                switch result {
//                case .success(_):
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    guard let productVC = storyboard.instantiateViewController(withIdentifier: "ProductVC") as? ProductViewController else {
//                        print("Could not instantiate DashboardVC")
//                        return
//                    }
//                    self?.navigationController?.pushViewController(productVC, animated: true)
//                case .failure(let error):
//                    self?.presentAlert(message: error.localizedDescription)
//                }
//            }
//        }
//    }
//
//    private func bindViewModel() {
//        viewModel.$isLoading.assign(to: \.isHidden, on: activityIndicator).store(in: &viewModel.cancellables)
//        viewModel.$error.sink { [weak self] error in
//            if let error = error {
//                self?.presentAlert(message: error.localizedDescription)
//            }
//        }.store(in: &viewModel.cancellables)
//
//        viewModel.$user.sink { [weak self] user in
//            if let user = user {
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                guard let productVC = storyboard.instantiateViewController(withIdentifier: "ProductVC") as? ProductViewController else {
//                    print("Could not instantiate DashboardVC")
//                    return
//                }
//                self?.navigationController?.pushViewController(productVC, animated: true)
//            }
//        }.store(in: &viewModel.cancellables)
//    }





//func login(withUsername username: String, password: String, completion: @escaping (Result<UserModel, ApiError>) -> Void) {
//    let loginRequest = LoginRequestModel(username: username, password: password)
//    let url = Constant.ApiEndPoint.loginApi
//
//    NetworkService.shared.makeRequestAndFetchData(with: loginRequest, from: url) { (result: Result<UserModel, ApiError>) in
//        completion(result)
//    }
//}


//func loginCombine() {
//    guard validateInput() else {
//        return
//    }
//
//    isLoading = true
//
//    let loginRequest = LoginRequestModel(username: username, password: password)
//    let url = Constant.ApiEndPoint.loginApi
//
//    Future<UserModel?, ApiError> { promise in
//        NetworkService.shared.makeRequestAndFetchData(with: loginRequest, from: url) { (result: Result<UserModel, ApiError>) in
//            switch result {
//            case .success(let userModel):
//                promise(.success(userModel))
//            case .failure(let apiError):
//                promise(.failure(apiError))
//            }
//        }
//    }
//    .receive(on: DispatchQueue.main)
//    .sink { [weak self] completion in
//        self?.isLoading = false
//        if case .failure(let apiError) = completion {
//            self?.error = .apiError(apiError)
//        }
//    } receiveValue: { [weak self] userModel in
//        self?.user = userModel
//        self?.isLoggedIn = true
//    }
//    .store(in: &cancellables)
//}




//var cancellables = Set<AnyCancellable>()
//
//func validateInput() -> Bool {
//    if username.isEmpty && password.isEmpty {
//        error = .loginInfoEmpty
//        return false
//    } else if username.isEmpty {
//        error = .usernameEmpty
//        return false
//    } else if password.isEmpty {
//        error = .passwordEmpty
//        return false
//    }
//    return true
//}




/*
 
 
 @IBAction func chooseCategoryButtonTapped(_ sender: Any) {
     let alertController = createAlertController()
     present(alertController, animated: true)
 }

 private func createAlertController() -> UIAlertController {
     let alertController = UIAlertController(title: "\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
     
     let pickerView = createPickerView(width: Int(alertController.view.bounds.width), height: 150)
     alertController.view.addSubview(pickerView)
     
     let selectAction = createSelectAction(for: pickerView)
     let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
     alertController.addAction(selectAction)
     alertController.addAction(cancelAction)
     return alertController
 }

 private func createPickerView(width: Int, height: Int) -> UIPickerView {
     let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: width, height: height))
     
     pickerView.delegate = self
     pickerView.dataSource = self
     return pickerView
 }

 private func createSelectAction(for pickerView: UIPickerView) -> UIAlertAction {
     let selectAction = UIAlertAction(title: "select", style: .default) { action in
         let choiceIndex = pickerView.selectedRow(inComponent: 0)
         let selectedCategory = ProductCategory.allCases[choiceIndex]
         self.fetchProductByCategory(selectedCategory)
     }
     return selectAction
 }

 private func fetchProductByCategory(_ category: ProductCategory) {
     viewModel.fetchProductByCategory(category: category.rawValue) { apiError in
         if let error = apiError {
             self.presentAlert(message: error.localizedDescription)
         } else {
             DispatchQueue.main.async {
                 self.tableView.reloadData()
             }
         }
     }
 }


 
 */



//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let productID = viewModel.productAtIndex(indexPath.row).id
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? ProductDetailViewController else {
//            fatalError("cannot instantiate DetailVC")
//        }
//
//        detailVC.viewModel = ProductDetailViewModel()
//        detailVC.viewModel.fetchProductDetails(productID: productID) { product, error in
//            if let error = error {
//                self.presentAlert(message: error.localizedDescription)
//            } else {
//                DispatchQueue.main.async {
//                    detailVC.configure(product: product)
//                }
//            }
//
//        }
//
//        self.navigationController?.pushViewController(detailVC, animated: true)
//    }

    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let productID = viewModel.productAtIndex(indexPath.row).id
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? ProductDetailViewController else {
//            fatalError("cannot instantiate DetailVC")
//        }
//
//        detailVC.viewModel = ProductDetailViewModel()
//        detailVC.viewModel.fetchProductDetails(productID: productID){ apiError in
//            if let error = apiError {
//                self.presentAlert(message: error.localizedDescription)
//            }
//        }
//
//        self.navigationController?.pushViewController(detailVC, animated: true)
//    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let productID = viewModel.productAtIndex(indexPath.row).id
//        viewModel.fetchProductDetails(productID: productID) { product, apiError in
//            if let error = apiError {
//                self.presentAlert(message: error.localizedDescription)
//            }
//
//            if let product = product {
//                DispatchQueue.main.async {
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    guard let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? ProductDetailViewController else {
//                        fatalError("cannot instaniate detail Vc")
//                    }
//                    detailVC.product = product
//                    self.navigationController?.pushViewController(detailVC, animated: true)
//                }
//            }
//        }
//    }

//
//  ViewController.swift
//  LoginTests
//
//  Created by Hanh Vo on 6/28/23.
//

import XCTest
@testable import Login

extension UIApplication {
    var currentWindow: UIWindow? {
        connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .first(where: { $0.isKeyWindow })
    }
}

class MockLoginViewModel: LoginViewModel {
    override func login(completion: @escaping (Result<UserModel, LoginError>) -> Void) {
        // Assuming User and ApiError are your types that represent the user data and API errors
        let mockUser = UserModel(id: 1, username: "kim", email: "email@gmail.com", firstName: "kim", lastName: "kim", gender: "male", image: "http://example.com", token: "wwww") // Populate with any mock data necessary
        completion(.success(mockUser))
    }
}

final class ViewControllerTests: XCTestCase {
    var loginVC: ViewController!
    var viewModel: MockLoginViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()

        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? ViewController
        loginVC.loadViewIfNeeded()
        viewModel = MockLoginViewModel()
        
        loginVC.viewModel = viewModel
       
    
        
//        viewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
//        viewController.loadViewIfNeeded()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        loginVC = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoginButtonTapped() {
        loginVC.loginButtonTapped(UIButton())
        XCTAssertTrue(loginVC.activityIndicator.isAnimating, "Activity indicator should start animating after login button is tapped")
    }
    
//    func testLoginSuccess() {
//        let expectation = XCTestExpectation(description: "Login completes")
//        let navigationController = UINavigationController(rootViewController: loginVC)
//        loginVC.viewModel.login { userInfo in
//           // dump(userInfo)
//            XCTAssertNotNil(userInfo)
//            expectation.fulfill()
//        }
//       // loginVC.loginButtonTapped(UIButton())
//        wait(for: [expectation], timeout: 1.0)
//        XCTAssertTrue(loginVC.activityIndicator.isHidden, "Activity indicator should stop animating after login succeeds")
//        dump(navigationController.topViewController)
//        XCTAssert(navigationController.topViewController is ProductViewController, "ProductViewController should be pushed after login succeeds")
//    }

    
//    func testSuccessfulLogin() {
//        // Assuming you have text fields and they're linked via IBOutlet
//        loginVC.usernameTextField.text = "TestUser"
//        loginVC.passwordTextField.text = "TestPassword"
//        let expectation = self.expectation(description: "log in succeeded")
//
//        viewModel.login { (result: Result<UserModel, LoginError>) in
//            switch result {
//            case .success(let userInfo):
//                XCTAssertNotNil(userInfo)
//                let topViewController = UIApplication.shared.currentWindow?.rootViewController?.navigationController?.visibleViewController
//                print(topViewController as Any)
//                XCTAssertTrue(topViewController is ProductViewController)
//                expectation.fulfill()
//                print("sdsdgdsgsdgsdgsdgsdg")
//            case .failure(_):
//                XCTFail("Expected success, but got failure.")
//            }
//        }
//        wait(for: [expectation], timeout: 3)
//    }
//    func testLoginSuccess(){
//        let expectation = self.expectation(description: "Wait for login result")
//        viewController.usernameTextField.text = "kminchelle"
//        viewController.passwordTextField.text = "0lelplR"
//        viewController.login()
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            XCTAssertTrue(self.viewController.navigationController?.topViewController is ProductViewController, "ProductViewController should be pushed \(String(describing: self.viewController.navigationController?.viewControllers))")
//            expectation.fulfill()
//        }
//
//        waitForExpectations(timeout: 10, handler: nil)
//    }
 

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

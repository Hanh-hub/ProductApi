//
//  LoginTests.swift
//  LoginTests
//
//  Created by Hanh Vo on 6/9/23.
//

import XCTest
@testable import Login

class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!

    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testLoginSuccess() {
        let expecation = expectation(description: "login")
        viewModel.username = "kminchelle"
        viewModel.password = "0lelplR"
        viewModel.login { result in
            switch result {
            case .success(let userInfo):
                XCTAssertTrue(self.viewModel.isLoggedIn)
                XCTAssertNotNil(userInfo)
                expecation.fulfill()
            case .failure(_):
                XCTAssertFalse(self.viewModel.isLoggedIn)
                XCTFail("Expected success but failed")
            }
        }
        wait(for: [expecation], timeout: 2)
    }

    func testLoginWithEmptyUsernameAndPassword() {
        let expecation = expectation(description: "login")
        viewModel.username = ""
        viewModel.password = ""
        viewModel.login { result in
            switch result {
            case .success:
                XCTFail("Success result should not be returned for empty username and password.")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, LoginError.loginInfoEmpty.localizedDescription, "Error should be loginInfoEmpty for empty username and password.")
                print("failed")
                expecation.fulfill()
            }
        }
        wait(for: [expecation],timeout: 2)
    }

    func testLoginWithEmptyUsername() {
        let expecation = expectation(description: "login failed")
        viewModel.username = ""
        viewModel.password = "password"
        viewModel.login { result in
            switch result {
            case .success:
                XCTFail("Success result should not be returned for empty username.")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, LoginError.usernameEmpty.localizedDescription, "Error should be usernameEmpty for empty username.")
                print("failed")
                expecation.fulfill()
            }
        }
        wait(for: [expecation], timeout: 2)
    }
    

    func testLoginWithEmptyPassword() {
        let expecation = expectation(description: "login")
        viewModel.username = "username"
        viewModel.password = ""
        viewModel.login { result in
            switch result {
            case .success:
                XCTFail("Success result should not be returned for empty password.")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, LoginError.passwordEmpty.localizedDescription, "Error should be passwordEmpty for empty password.")
                expecation.fulfill()
            }
        }
        wait(for: [expecation], timeout: 2)
    }
    
    
    func testInvalidCredentials() {
        viewModel.username = "invalidUsername"
        viewModel.password = "invalidPassword"
        let expecation = expectation(description: "login")
        viewModel.login { result in
            switch result {
            case .success(_):
                XCTFail("Success result should not be returned for invalid credentials")
            case .failure(let error):
                if case LoginError.apiError(.decodingFailed(_)) = error {
                    XCTAssert(true, "Received expected error for invalid credentials")
                    expecation.fulfill()
                } else {
                    XCTFail("Received unexpected error for invalid credentials")
                }
                //XCTAssertEqual(error.localizedDescription, LoginError.apiError(.decodingFailed(error)))
                
            }
        }
        wait(for: [expecation], timeout: 3)
    }
}

//
//  ProductViewModelTests.swift
//  LoginTests
//
//  Created by Hanh Vo on 6/28/23.
//

import XCTest
@testable import Login
import Combine
import Foundation

final class ProductViewModelTests: XCTestCase {
    var viewModel: ProductListViewModel!

    override func setUpWithError() throws {
       viewModel = ProductListViewModel()
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        viewModel = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: -Test sucess
    
    func testFetchSuccess(){
        let expectation = expectation(description: "fetch product")
        viewModel.fetchProducts { apiError in
            XCTAssertNil(apiError)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2){_ in
            XCTAssertFalse(self.viewModel.products.isEmpty)
        }
    }
    
    func testFetchProductsBySearchSuccess() {
        let expectation = self.expectation(description: "Products fetched")

        viewModel.fetchProducts(by: "iphone") { apiError in
            XCTAssertNil(apiError, "There was an error fetching products: \(apiError!)")
            //XCTAssertFalse(self.viewModel.products.isEmpty, "No products were fetched")

            expectation.fulfill()
        }
        waitForExpectations(timeout: 2) {_ in
            XCTAssertFalse(self.viewModel.products.isEmpty)
        }
    }
    
    
//    func testFetchProductByCategorySuccess() {
//        let categories = [ProductCategory.automotive, ProductCategory.womensShoes, ProductCategory.furniture] //
//
//        var subscriptions = Set<AnyCancellable>()
//
//        for category in categories {
//            let expectation = XCTestExpectation(description: "Products fetched for \(category.rawValue)")
//
//            viewModel.$products
//                .filter { !$0.isEmpty && $0.count > 0 }
//                .first()
//                .sink { _ in
//                    expectation.fulfill()
//                }
//                .store(in: &subscriptions)
//
//            viewModel.fetchProductByCategory(category: category.rawValue) { apiError in
//                XCTAssertNil(apiError, "There was an error fetching products: \(apiError!)")
//            }
//            wait(for: [expectation], timeout: 2)
//        }
//    }
    
    func testFetchProductByCategory() {
        let category = "sunglasses"
        let expectation = expectation(description: "Products fetched for \(category)")

        viewModel.fetchProductByCategory(category: category) { apiError in
            XCTAssertNil(apiError, "There was an error fetching products: \(apiError!)")
            expectation.fulfill()
        }
        //wait(for: [expectation], timeout: 2)
        waitForExpectations(timeout: 2){_ in
            XCTAssertGreaterThan(self.viewModel.products.count, 1)
        }
    }
    
    func testFetchAllCategories(){
        let expectation = self.expectation(description: "Fetched categories")
        
        viewModel.fetchCategories { apiError in
            XCTAssertNil(apiError, "There was an error fetching products: \(apiError!)")
            
            XCTAssertGreaterThan(self.viewModel.categories.count, 0)
            print("viewmodel.categories.counts = ",self.viewModel.categories.count)
            expectation.fulfill()
        }
        wait(for: [expectation])
      //  waitForExpectations(timeout: 2)
    }
    
    func testFetchAllCategoriesFailure(){
        
        let expectation = self.expectation(description: "Fetched categories")
        
        Constant.ApiEndPoint.categoriesApi = ""
        
        viewModel.fetchCategories { apiError in
            XCTAssertNotNil(apiError, "There was an error fetching products: \(apiError!)")
            expectation.fulfill()
        }
        wait(for: [expectation])
    }
    

    //MARK: - Test failure

    
    func testFetchCategoriesFailed(){
        let category = "invalid-category"
        let expectation = expectation(description: "Products fetched for \(category)")

        viewModel.fetchProductByCategory(category: category) { apiError in
            //XCTAssertNil(apiError, "There was an error fetching products: \(apiError!)")
            XCTAssertEqual(self.viewModel.products.count, .zero)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
  
    }
    
    func testFetchProductsInvalidSearchText() {
       let expectation = self.expectation(description: "Products fetched")

        viewModel.fetchProducts(by: "afgefegwgbwgvwevw") { apiError in
            XCTAssertNil(apiError, "There was an error fetching products: \(apiError!)")
            print("Ssgs")

            expectation.fulfill()
        }
        waitForExpectations(timeout: 2) {_ in
            XCTAssertTrue(self.viewModel.products.isEmpty)
        }
    }

    
    func numsOfRowsInSection(){
        let expectation = self.expectation(description: "Products fetched")
        viewModel.fetchProducts { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2){_ in
            XCTAssertGreaterThan(self.viewModel.numberOfRowsInSection(), 20)
        }
    }
    
    
    func testProductAtIndex(){
        let expectation = self.expectation(description: "Products fetched")
        viewModel.fetchProducts { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2){_ in
            XCTAssertEqual(self.viewModel.productAtIndex(1).title, "iPhone X")
        }
    }

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

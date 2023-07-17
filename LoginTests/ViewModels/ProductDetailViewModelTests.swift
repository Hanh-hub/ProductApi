//
//  ProductDetailViewModelTests.swift
//  LoginTests
//
//  Created by Hanh Vo on 6/30/23.
//

import XCTest
import Combine
@testable import Login

final class ProductDetailViewModelTests: XCTestCase {
    var sut: ProductDetailViewModel!
    var cancellable: AnyCancellable?
 
    override func setUpWithError() throws {
        super.setUp()
        sut = ProductDetailViewModel()
        //cancellable = Set<AnyCancellable>()
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        super.tearDown()
        sut = nil
        cancellable = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Test success
    
    func testFetchDetailSuccess(){
        let expectation = self.expectation(description: "fetch detail success")
        
        cancellable = sut.$product
            .filter({ product in
                product != nil
            })
            .first()
            .sink { _ in
                expectation.fulfill()
            }
           // .store(in: &cancellable)
        
        sut.fetchProductDetails(productID: 1) { error in
            XCTAssertNil(error)
        }
        
        wait(for: [expectation], timeout: 2)
        
    }

    
    func testFetchProductDetailsSuccess() {
        let expectation = self.expectation(description: "Fetch Product Details Success")
        sut.fetchProductDetails(productID: 1) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)  //Increased timeout due to network call
        XCTAssertNotNil(sut.product)
    }
// MARK: - test failure
    
    func testFetchDetailFailure(){
        let expectation = self.expectation(description: "fetch detail success")
        
        cancellable = sut.$product
            .filter { $0 != nil}
            .first()
            .sink { _ in
                XCTFail("Expected failure")
            }
           // .store(in: &cancellable)
        
        sut.fetchProductDetails(productID: 10000) { error in
            XCTAssertNotNil(error)
            
            switch error {
            case .badStatusCode(let statusCode):
                XCTAssertEqual(statusCode, 404)
            default:
                XCTFail("Expected .badStatusCode error, but received \(error!)")
                
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        
    }
    
    func testProductSubscriber() {
        let expectation = self.expectation(description: "Product Subscriber")
        var product: Product? = nil

        sut.setUpSubscriber { fetchedProduct in
            product = fetchedProduct
            //XCTAssertNotNil(fetchedProduct)
        }

        sut.fetchProductDetails(productID: 1) { error in
            XCTAssertNil(error)
            XCTAssertNotNil(product)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
    }
    
    func testProductSubscriber2() {
        let expectation = self.expectation(description: "Product Subscriber")

        var cancellable: AnyCancellable? = sut.$product
            .filter{ $0 != nil}
            .sink { product in
                //if let product = product {
                    XCTAssertNotNil(product)
                    expectation.fulfill()
               // }
            }
            
        sut.fetchProductDetails(productID: 1) { error in
            XCTAssertNil(error)
        }

        wait(for: [expectation], timeout: 3)

        // To avoid memory leaks
        cancellable = nil
    }

    func testProductSubscriber3() {
        let expectation = self.expectation(description: "Product Subscriber")
        //var product: Product? = nil

        sut.setUpSubscriber { fetchedProduct in
            //if fetchedProduct != nil {
                XCTAssertNotNil(fetchedProduct)
                expectation.fulfill()
          //  }
            //XCTAssertNotNil(fetchedProduct)
        }

        sut.fetchProductDetails(productID: 1) { error in
            XCTAssertNil(error)
            //XCTAssertNotNil(product)
           // expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
    }



    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

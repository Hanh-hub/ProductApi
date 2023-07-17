//
//  ProductTableViewCellTests.swift
//  LoginTests
//
//  Created by Hanh Vo on 6/30/23.
//

import XCTest
@testable import Login
final class ProductTableViewCellTests: XCTestCase {
    
    //var sut: ProductTableViewCell!
    var cell: ProductTableViewCell!


    override func setUpWithError() throws {
        cell = ProductTableViewCell()
        cell.awakeFromNib()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
//    func testConfigureSetsUIElementsCorrectly() {
//        // Create a dummy product
//        let mockProduct = Product(id: 1, title: "Mock Product", description: "test", price: 123.45, discountPercentage: nil, rating: 3.5, stock: nil, brand: nil, category: nil, thumbnail: nil, images: nil)
//        cell.configure(with: mockProduct)
//        
//        // Test that UI elements are set correctly
//        XCTAssertEqual(cell.titleLabel.text, mockProduct.title)
//        // Other assertions...
//    }


//    func testExample() throws {
//        let mockProduct = Product(id: 1, title: "Mock Product", description: "test", price: 123.45, discountPercentage: nil, rating: 3.5, stock: nil, brand: nil, category: nil, thumbnail: nil, images: nil)
//        
//        let tableView = UITableView()
////        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil),
////                           forCellReuseIdentifier: "productCell")
//        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "productCell")
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! ProductTableViewCell
//        
//        // 3. Call the `configure(with:)` method with the mock product.
////        cell.configure(with: mockProduct)
////
////        XCTAssertEqual(cell.titleLabel.text, "Mock Product")
////        XCTAssertEqual(cell.priceLabel.text, "Now $123.45")
////        XCTAssertEqual(cell.starImageView1.image, UIImage(systemName: "star.fill"))
////        XCTAssertEqual(cell.starImageView2.image, UIImage(systemName: "star.fill"))
////        XCTAssertEqual(cell.starImageView3.image, UIImage(systemName: "star.fill"))
////        XCTAssertEqual(cell.starImageView4.image, UIImage(systemName: "star.leadinghalf.fill"))
////        XCTAssertEqual(cell.starImageView5.image, UIImage(systemName: "star"))
//               
//    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

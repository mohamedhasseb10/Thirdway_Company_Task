//
//  ThirdwayTaskTests.swift
//  ThirdwayTaskTests
//
//  Created by Mohamed Hasseb on 27/01/2022.
//

import XCTest
@testable import ThirdwayTask

class ThirdwayTaskTests: XCTestCase {
    var stubProductListRepository: ProductListRepository!
    var productListViewModel: ProductListViewModel!
    var productListViewController: ProductListViewController!
    var productDetailsViewController: ProductDetailsViewController!
    override func setUp() {
        stubProductListRepository = ProductListRepository(LocalClient(fileName: "stub_productlist_response"))
        productListViewModel = ProductListViewModel(stubProductListRepository)
        productListViewController = ProductListViewController()
        productDetailsViewController = ProductDetailsViewController()
        productListViewModel?.getProductList()
        productListViewController.viewModel = productListViewModel!
    }
    
    override func tearDown() {
        stubProductListRepository = nil
        productListViewModel = nil
        productListViewController = nil
        productDetailsViewController = nil
    }

    func testProductDetailsSelectedItem_NotNil() {
        //Arrange
        guard let productData = productListViewModel?.getProductItem(at: 0) else {return}
        productListViewController.navigate(to: productDetailsViewController, with: productData)
        //Act
        let productSelected = productDetailsViewController.viewModel.productSelected
        //Assert
        XCTAssertNotNil(productSelected)
    }
    
    func testProductDetailsSelectedItem_priceEqual() {
        //Arrange
        guard let productData = productListViewModel?.getProductItem(at: 0) else {return}
        productListViewController.navigate(to: productDetailsViewController, with: productData)
        //Act
        let productSelected = productDetailsViewController.viewModel.productSelected
        //Assert
        XCTAssertTrue(productData.price == productSelected.price)
    }
    
    func testProductDetailsSelectedItem_descriptionEqual() {
        //Arrange
        guard let productData = productListViewModel?.getProductItem(at: 0) else {return}
        productListViewController.navigate(to: productDetailsViewController, with: productData)
        //Act
        let productSelected = productDetailsViewController.viewModel.productSelected
        //Assert
        XCTAssertTrue(productData.price == productSelected.price)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

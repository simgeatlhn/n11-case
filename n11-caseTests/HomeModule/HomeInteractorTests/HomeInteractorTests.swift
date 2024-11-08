//
//  HomeInteractorTests.swift
//  n11-caseTests
//
//  Created by simge on 8.11.2024.
//

import XCTest
@testable import n11_case

class HomeInteractorTests: XCTestCase {
    var interactor: HomeInteractor!
    var mockNetworkService: MockNetworkService!
    var mockOutput: MockHomeInteractorOutputs!
    
    struct TestFailureMessage {
        static let fetchedProductsDataNotCalled = "fetchedProductsData should be called"
        static let fetchProductsMismatch = "Fetched products should match sample products"
        static let successExpected = "Success was expected, but received a different result"
        static let invalidURLErrorNotCalled = "Invalid URL error was expected, but received a different result"
        static let filteredProductsDataNotCalled = "filteredProductsData should be called"
        static let emptyQueryReturnedIncorrectCount = "An empty query should return all products"
        static let queryResultMismatch = "All products containing the query should be returned"
    }
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        interactor = HomeInteractor(networkService: mockNetworkService)
        mockOutput = MockHomeInteractorOutputs()
        interactor.output = mockOutput
    }
    
    override func tearDown() {
        interactor = nil
        mockNetworkService = nil
        mockOutput = nil
        super.tearDown()
    }
    
    func testFetchProductsData_Success() {
        let sampleProducts = [
            ProductEntity(id: 514298766, title: "Apple iPhone 13 Pro 1 TB (Apple TÃ¼rkiye Garantili)", imageUrl: "https://n11scdn.akamaized.net/a1/{0}/elektronik/cep-telefonu/apple-iphone-13-pro-1-tb-apple-turkiye-garantili__1584725628235073.jpg", price: 30099, instantDiscountPrice: 29999, rate: 1.7, sellerName: "exbilisim")
        ]
        
        let responseData = ResponseData(page: "1", nextPage: "2", sponsoredProducts: [], products: sampleProducts)
        mockNetworkService.result = .success(responseData)
        let expectation = self.expectation(description: "FetchProductsDataSuccess")
        interactor.fetchProductsData(page: 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.mockOutput.fetchedProductsDataCalled, TestFailureMessage.fetchedProductsDataNotCalled)
            switch self.mockOutput.fetchedResult {
            case .success(let data):
                XCTAssertEqual(data.products, sampleProducts, TestFailureMessage.fetchProductsMismatch)
            default:
                XCTFail(TestFailureMessage.successExpected)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchProductsData_InvalidURL() {
        mockNetworkService.result = .failure(NetworkError.invalidURL)
        let expectation = self.expectation(description: "FetchProductsDataInvalidURL")
        interactor.fetchProductsData(page: 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.mockOutput.fetchedProductsDataCalled, TestFailureMessage.fetchedProductsDataNotCalled)
            switch self.mockOutput.fetchedResult {
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, NetworkError.invalidURL, TestFailureMessage.invalidURLErrorNotCalled)
            default:
                XCTFail(TestFailureMessage.invalidURLErrorNotCalled)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSearchProducts_WithEmptyQuery() {
        interactor.allProducts = [
            ProductEntity(id: 1, title: "Product 1", imageUrl: "url1", price: 100.0, instantDiscountPrice: 90.0, rate: 4.5, sellerName: "Seller1"),
        ]
        
        let expectation = self.expectation(description: "SearchProductsEmptyQuery")
        interactor.searchProducts(with: "")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.mockOutput.filteredProductsDataCalled, TestFailureMessage.filteredProductsDataNotCalled)
            XCTAssertEqual(self.mockOutput.filteredProducts?.count, 1, TestFailureMessage.emptyQueryReturnedIncorrectCount)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSearchProducts_WithNonEmptyQuery() {
        interactor.allProducts = [
            ProductEntity(id: 1, title: "Product 1", imageUrl: "url1", price: 100.0, instantDiscountPrice: 90.0, rate: 4.5, sellerName: "Seller1"),
        ]
        
        let expectation = self.expectation(description: "SearchProductsNonEmptyQuery")
        interactor.searchProducts(with: "Product")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.mockOutput.filteredProductsDataCalled, TestFailureMessage.filteredProductsDataNotCalled)
            XCTAssertEqual(self.mockOutput.filteredProducts?.count, 1, TestFailureMessage.queryResultMismatch)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}

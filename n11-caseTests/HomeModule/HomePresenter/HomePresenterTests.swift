//
//  HomePresenterTests.swift
//  n11-caseTests
//
//  Created by simge on 8.11.2024.
//

import XCTest
@testable import n11_case

class HomePresenterTests: XCTestCase {
    var presenter: HomePresenter!
    var mockView: MockHomeView!
    var mockInteractor: MockHomeInteractor!
    var mockRouter: MockHomeRouter!
    
    override func setUp() {
        super.setUp()
        mockView = MockHomeView()
        mockInteractor = MockHomeInteractor()
        mockRouter = MockHomeRouter()
        presenter = HomePresenter(view: mockView, interactor: mockInteractor, router: mockRouter)
    }
    
    override func tearDown() {
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        presenter = nil
        super.tearDown()
    }

    func testViewDidLoad() {
        presenter.viewDidLoad()
        XCTAssertTrue(mockView.didShowLoadingIndicator)
        XCTAssertTrue(mockInteractor.didFetchProductsData)
    }
    
    func testDidSelectProduct() {
        let productId = 123
        presenter.didSelectProduct(withId: productId)
        XCTAssertTrue(mockRouter.didNavigateToProductDetail)
    }
    
    func testSearchProducts() {
        presenter.searchProducts(with: "query")
        XCTAssertTrue(mockView.didShowLoadingIndicator)
        XCTAssertTrue(mockInteractor.didSearchProducts)
    }
    
    func testFetchedProductsDataSuccess() {
        let responseData = ResponseData(
            page: "1",
            nextPage: "2",
            sponsoredProducts: [],
            products: []
        )
        presenter.fetchedProductsData(result: .success(responseData))
        XCTAssertFalse(mockView.didShowLoadingIndicator)
        XCTAssertTrue(mockView.didReloadData)
    }
    
    func testFetchedProductsDataFailure() {
        let error = NSError(domain: "", code: -1, userInfo: nil)
        presenter.fetchedProductsData(result: .failure(error))
        XCTAssertTrue(mockView.didShowError)
    }
}

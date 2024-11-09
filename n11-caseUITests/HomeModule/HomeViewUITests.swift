//
//  HomeViewUITests.swift
//  n11-caseUITests
//
//  Created by simge on 8.11.2024.
//

import XCTest

class HomeUITestCase: XCTestCase {
    var app: XCUIApplication!
    
    struct AccessibilityIdentifier {
        static let homeScreen = "homeScreen"
        static let searchTextField = "searchTextField"
        static let sponsoredProductsCollectionView = "sponsoredProductsCollectionView"
        static let productsCollectionView = "productsCollectionView"
    }
    
    struct TestFailureMessage {
        static let homeScreenNotDisplayed = "Ana ekran görüntülenemedi."
        static let searchTextFieldNotFound = "Arama TextField bulunamadı."
        static let sponsoredProductsCollectionViewNotFound = "Sponsorlu Ürünler CollectionView bulunamadı."
        static let productsCollectionViewNotFound = "Ürünler CollectionView bulunamadı."
        static let searchFunctionalityFailed = "Arama fonksiyonu başarısız oldu. Ürünler CollectionView doğru şekilde güncellenmedi."
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.textFields[AccessibilityIdentifier.searchTextField].waitForExistence(timeout: 10), TestFailureMessage.homeScreenNotDisplayed)
    }
    
    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }
    
    func testHomeScreenElementsPresence() throws {
        let searchTextField = app.textFields[AccessibilityIdentifier.searchTextField]
        XCTAssertTrue(searchTextField.exists, TestFailureMessage.searchTextFieldNotFound)
        
        let sponsoredCollectionView = app.collectionViews[AccessibilityIdentifier.sponsoredProductsCollectionView]
        XCTAssertTrue(sponsoredCollectionView.exists, TestFailureMessage.sponsoredProductsCollectionViewNotFound)
        
        let productsCollectionView = app.collectionViews[AccessibilityIdentifier.productsCollectionView]
        XCTAssertTrue(productsCollectionView.exists, TestFailureMessage.productsCollectionViewNotFound)
    }
    
    func testSearchFunctionality() throws {
        let searchTextField = app.textFields[AccessibilityIdentifier.searchTextField]
        XCTAssertTrue(searchTextField.exists, TestFailureMessage.searchTextFieldNotFound)
        
        searchTextField.tap()
        searchTextField.typeText("128")
        app.keyboards.buttons["Search"].tap()
        
        let productsCollectionView = app.collectionViews[AccessibilityIdentifier.productsCollectionView]
        XCTAssertTrue(productsCollectionView.waitForExistence(timeout: 10), TestFailureMessage.searchFunctionalityFailed)
    }
}


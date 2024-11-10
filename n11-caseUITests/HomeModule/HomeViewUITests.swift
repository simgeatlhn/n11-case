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
        static let homeScreenNotDisplayed = "Home screen could not be displayed."
        static let searchTextFieldNotFound = "Search TextField was not found."
        static let sponsoredProductsCollectionViewNotFound = "Sponsored Products CollectionView was not found."
        static let productsCollectionViewNotFound = "Products CollectionView was not found."
        static let searchFunctionalityFailed = "Search functionality failed. Products CollectionView was not updated correctly."
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


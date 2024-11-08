// HomeUITestCase.swift

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
        static let homeScreenNotDisplayed = "Home screen is not displayed."
        static let searchTextFieldNotFound = "Search TextField is not found."
        static let sponsoredProductsCollectionViewNotFound = "Sponsored Products CollectionView is not found."
        static let productsCollectionViewNotFound = "Products CollectionView is not found."
        static let searchFunctionalityFailed = "Search functionality failed. Products CollectionView did not update correctly."
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
        let searchTextField = app.textFields[AccessibilityIdentifier.searchTextField]
        XCTAssertTrue(searchTextField.waitForExistence(timeout: 10), TestFailureMessage.homeScreenNotDisplayed)
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testHomeScreenElementsPresence() throws {
        let app = XCUIApplication()
        let searchTextField = app.textFields[AccessibilityIdentifier.searchTextField]
        XCTAssertTrue(searchTextField.exists, TestFailureMessage.searchTextFieldNotFound)
        let sponsoredCollectionView = app.collectionViews[AccessibilityIdentifier.sponsoredProductsCollectionView]
        XCTAssertTrue(sponsoredCollectionView.exists, TestFailureMessage.sponsoredProductsCollectionViewNotFound)
        let productsCollectionView = app.collectionViews[AccessibilityIdentifier.productsCollectionView]
        XCTAssertTrue(productsCollectionView.exists, TestFailureMessage.productsCollectionViewNotFound)
    }
    
    func testSearchFunctionality() throws {
        let app = XCUIApplication()
        let searchTextField = app.textFields[AccessibilityIdentifier.searchTextField]
        XCTAssertTrue(searchTextField.exists, TestFailureMessage.searchTextFieldNotFound)
        searchTextField.tap()
        searchTextField.typeText("iPhone")
        app.keyboards.buttons["Search"].tap()
        let productsCollectionView = app.collectionViews[AccessibilityIdentifier.productsCollectionView]
        XCTAssertTrue(productsCollectionView.waitForExistence(timeout: 10), TestFailureMessage.searchFunctionalityFailed)
    }
}

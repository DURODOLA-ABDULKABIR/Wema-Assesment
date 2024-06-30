//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by durodola on 28/06/2024.
//

import XCTest
@testable import WeatherApp

class HomeViewControllerTests: XCTestCase {

    var viewController: HomeViewController!
    var mockNetworkManager: MockWeatherDetailsNetwork!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockWeatherDetailsNetwork()
        viewController = HomeViewController(networkManager: mockNetworkManager)
            viewController.loadViewIfNeeded()
    }

    override func tearDown() {
        viewController = nil
        mockNetworkManager = nil
        super.tearDown()
    }

    func testGetWeatherDetailsCalled() {
        viewController.cityNameTextfield.text = "Lagos"
        viewController.getWeatherDetails()
        XCTAssertTrue(mockNetworkManager.getWeatherDetailsCalled, "The getWeatherDetails method was not called")
    }

    func testSwitchButton() {
        viewController.cityNameTextfield.text = "Lagos"
        viewController.switchButton.isOn = true
        viewController.onSwitchValueChanged(sender: viewController.switchButton)
        XCTAssertEqual(UserDefault.getSavedCity(), "Lagos", "The city name was not saved correctly")
        viewController.switchButton.isOn = false
        viewController.onSwitchValueChanged(sender: viewController.switchButton)
        XCTAssertNil(UserDefault.getSavedCity(), "The city name was not removed correctly")
    }
}

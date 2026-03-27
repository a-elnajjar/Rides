//
//  VehicleListViewModelTests.swift
//  RidesTests
//
//  Created by Abdalla Elnajjar on 2024-10-04.
//

import XCTest
@testable import Rides

class VehicleListViewModelTests: XCTestCase {

	var viewModel: VehicleListViewModel!

	override func setUp() {
		super.setUp()
		viewModel = VehicleListViewModel()
	}

	override func tearDown() {
		viewModel = nil
		super.tearDown()
	}

	func testValidInput() {
		viewModel.inputCount = "10"
		XCTAssertTrue(viewModel.isValidInput())
	}

	func testInvalidInputNonInteger() {
		viewModel.inputCount = "abc"
		XCTAssertFalse(viewModel.isValidInput())
	}

	func testInvalidInputOutOfRange() {
		viewModel.inputCount = "101"
		XCTAssertFalse(viewModel.isValidInput())
	}

	func testInputInRange() {
		viewModel.inputCount = "50"
		XCTAssertTrue(viewModel.isValidInput())
	}
	
	func testInputInNegativeInteger() {
		viewModel.inputCount = "-3"
		XCTAssertFalse(viewModel.isValidInput())
	}
}

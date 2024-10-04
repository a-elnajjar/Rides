//
//  CarbonEmissionsViewModelTests.swift
//  Rides
//
//  Created by Abdalla Elnajjar on 2024-10-04.
//


import XCTest
@testable import Rides


class CarbonEmissionsViewModelTests: XCTestCase {

	func testEmissionsForKilometrageUnder5000() {
		// Given
		let vehicle = Vehicle(id: 1, uid: UUID(), vin: "1234", makeAndModel: "Test Car", color: "Red", transmission: "Automatic", driveType: .awd, fuelType: "Gasoline", carType: "Sedan", carOptions: [], specs: [], doors: 4, mileage: 4000, kilometrage: 4000, licensePlate: "ABC123")
		let viewModel = CarbonEmissionsViewModel(vehicle: vehicle)

		// When
		let emissions = viewModel.emissions

		// Then
		XCTAssertEqual(emissions, 4000.0, "Emissions should be equal to the kilometrage when under 5000km")
	}

	func testEmissionsForKilometrageExactly5000() {
		// Given
		let vehicle = Vehicle(id: 2, uid: UUID(), vin: "5678", makeAndModel: "Test SUV", color: "Blue", transmission: "Manual", driveType: .rwd, fuelType: "Diesel", carType: "SUV", carOptions: [], specs: [], doors: 4, mileage: 5000, kilometrage: 5000, licensePlate: "DEF456")
		let viewModel = CarbonEmissionsViewModel(vehicle: vehicle)

		// When
		let emissions = viewModel.emissions

		// Then
		XCTAssertEqual(emissions, 5000.0, "Emissions should be 5000.0 units when kilometrage is exactly 5000km")
	}

	func testEmissionsForKilometrageAbove5000() {
		// Given
		let vehicle = Vehicle(id: 3, uid: UUID(), vin: "91011", makeAndModel: "Test Truck", color: "Black", transmission: "Automatic", driveType: .fwd, fuelType: "Gasoline", carType: "Truck", carOptions: [], specs: [], doors: 2, mileage: 7000, kilometrage: 7000, licensePlate: "GHI789")
		let viewModel = CarbonEmissionsViewModel(vehicle: vehicle)

		// When
		let emissions = viewModel.emissions

		// Then
		let expectedEmissions = 5000.0 * 1.0 + 2000.0 * 1.5 // First 5000 km = 5000 units, next 2000 km = 3000 units
		XCTAssertEqual(emissions, expectedEmissions, "Emissions calculation for kilometrage over 5000km is incorrect")
	}
}

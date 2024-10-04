//
//  VehicleListViewModel.swift
//  Rides
//
//  Created by Abdalla Elnajjar on 2024-10-04.
//

import Foundation

class VehicleListViewModel: ObservableObject {
	enum SortOption: String, CaseIterable {
		case vin = "VIN"
		case carType = "Car Type"
	}

	@Published var vehicles: [Vehicle] = []
	@Published var inputCount: String = ""
	@Published var selectedSortOption: SortOption = .vin

	private let vehicleService = VehicleService()

	
	func isValidInput() -> Bool {
		if let count = Int(inputCount), (1...100).contains(count) {
			return true
		}
		return false
	}

	
	func fetchVehicles() {
		guard isValidInput() else {
			print("Invalid input")
			return
		}

		guard let count = Int(inputCount) else { return }

		vehicleService.fetchVehicles(count: count) { [weak self] result in
			DispatchQueue.main.async {
				switch result {
				case .success(let vehicles):
					self?.vehicles = vehicles
					self?.sortVehicles()
				case .failure(let error):
					print("Failed to fetch vehicles: \(error)")
				}
			}
		}
	}

	func sortVehicles() {
		switch selectedSortOption {
		case .vin:
			vehicles.sort(by: { $0.vin.localizedStandardCompare($1.vin) == .orderedAscending })
		case .carType:
			vehicles.sort(by: { $0.carType.localizedStandardCompare($1.carType) == .orderedAscending })
		}
	}
}

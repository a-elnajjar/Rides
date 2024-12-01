//
//  VehicleListViewModel.swift
//  Rides
//
//  Created by Abdalla Elnajjar on 2024-10-04.
//

import Foundation
import Combine

class VehicleListViewModel: ObservableObject {
	enum SortOption: String, CaseIterable {
		case vin = "VIN"
		case carType = "Car Type"
	}

	// MARK: - Published Properties
	@Published var vehicles: [Vehicle] = []
	@Published var inputCount: String = ""
	@Published var selectedSortOption: SortOption = .vin
	@Published var isLoading: Bool = false // Track loading state

	// MARK: - Private Properties
	private let networkManager = NetworkManager.shared
	private var cancellables = Set<AnyCancellable>()

	// MARK: - Validation
	func isValidInput() -> Bool {
		guard let count = Int(inputCount), (1...100).contains(count) else {
			return false
		}
		return true
	}

	// MARK: - Fetch Vehicles
	func fetchVehicles() {
		guard let count = Int(inputCount), isValidInput() else {
			print("Invalid input. Please enter a number between 1 and 100.")
			return
		}

		let urlString = "https://random-data-api.com/api/vehicle/random_vehicle?size=\(count)"
		isLoading = true // Start loading
		fetchVehiclesFromNetwork(urlString: urlString)
	}

	private func fetchVehiclesFromNetwork(urlString: String) {
		networkManager.fetchData(from: urlString, responseType: [Vehicle].self)
			.subscribe(on: DispatchQueue.global(qos: .background))
			.map { vehicles -> [Vehicle] in
				vehicles.sorted(by: { $0.vin.localizedStandardCompare($1.vin) == .orderedAscending })
			}
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { [weak self] completion in
				self?.isLoading = false // Stop loading
				switch completion {
				case .finished:
					break
				case .failure(let error):
					self?.handleError(error)
				}
			}, receiveValue: { [weak self] sortedVehicles in
				self?.vehicles = sortedVehicles
			})
			.store(in: &cancellables)
	}

	private func handleError(_ error: Error) {
		print("Error fetching vehicles: \(error.localizedDescription)")
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

//
//  VehicleListViewModel.swift
//  Rides
//
//  Created by Abdalla Elnajjar on 2024-10-04.
//

//
//  VehicleListViewModel.swift
//  Rides
//
//  Created by Abdalla Elnajjar on 2024-10-04.
//

import Foundation

protocol NetworkServiceProtocol {
	func fetchData<T: Decodable>(from urlString: String,
	responseType: T.Type) async throws -> T
}

extension NetworkManager: NetworkServiceProtocol {}

final class VehicleListViewModel: ObservableObject {
	
	enum SortOption: String, CaseIterable, Hashable {
		case vin = "VIN"
		case carType = "Car Type"
	}
	
	@Published var vehicles: [Vehicle] = []
	@Published var inputCount: String = ""
	@Published var selectedSortOption: SortOption = .vin {
		didSet {
			Task { @MainActor in
				self.sortVehicles()
			}
		}
	}
	@Published var isLoading: Bool = false
	@Published var errorMessage: String?
	
	private let networkService: NetworkServiceProtocol
	private var fetchTask: Task<Void, Never>?
	
	init(networkService: NetworkServiceProtocol = NetworkManager.shared) {
		self.networkService = networkService
	}
	
	func isValidInput() -> Bool {
		guard let count = Int(inputCount), (1...100).contains(count) else {
			return false
		}
		return true
	}
	
	func fetchVehicles() {
		guard let count = Int(inputCount), isValidInput() else {
			errorMessage = "Please enter a number between 1 and 100."
			return
		}
		
		let urlString = "https://random-data-api.com/api/vehicle/random_vehicle?size=\(count)"
		
		fetchTask?.cancel()
		
		fetchTask = Task {
			await fetchVehiclesAsync(urlString: urlString)
		}
	}
	
	private func fetchVehiclesAsync(urlString: String) async {
		await MainActor.run {
			self.isLoading = true
			self.errorMessage = nil
		}
		
		do {
			var fetchedVehicles = try await networkService.fetchData(
				from: urlString,
				responseType: [Vehicle].self
			)
			
			fetchedVehicles = sortedVehicles(fetchedVehicles)
			
			await MainActor.run {
				self.vehicles = fetchedVehicles
				self.isLoading = false
			}
		} catch let error as NetworkError {
			await MainActor.run {
				self.errorMessage = error.errorDescription ?? "Failed to fetch vehicles"
				self.isLoading = false
			}
		} catch {
			await MainActor.run {
				self.errorMessage = "An unexpected error occurred"
				self.isLoading = false
			}
		}
	}
	
	func sortVehicles() {
		vehicles = sortedVehicles(vehicles)
	}
	
	private func sortedVehicles(_ vehicleList: [Vehicle]) -> [Vehicle] {
		switch selectedSortOption {
		case .vin:
			return vehicleList.sorted { $0.vin.localizedStandardCompare($1.vin) == .orderedAscending }
		case .carType:
			return vehicleList.sorted { $0.carType.localizedStandardCompare($1.carType) == .orderedAscending }
		}
	}
	
	func cancelFetch() {
		fetchTask?.cancel()
		isLoading = false
	}
}

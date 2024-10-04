//
//  VehicleService.swift
//  Rides
//
//  Created by Abdalla Elnajjar on 2024-10-04.
//

import Foundation

import Foundation

enum VehicleServiceError: Error {
	case invalidInput
	case invalidURL
	case networkError(Error)
	case dataCorrupted
	case decodingError(Error)
}

class VehicleService {
	
	func fetchVehicles(count: Int, completion: @escaping (Result<[Vehicle], Error>) -> Void) {
		guard (1...100).contains(count) else {
			completion(.failure(VehicleServiceError.invalidInput))
			return
		}
		
		let urlString = "https://random-data-api.com/api/vehicle/random_vehicle?size=\(count)"
		guard let url = URL(string: urlString) else {
			completion(.failure(VehicleServiceError.invalidURL))
			return
		}
		
		URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				completion(.failure(VehicleServiceError.networkError(error)))
				return
			}
			
			guard let data = data else {
				completion(.failure(VehicleServiceError.dataCorrupted))
				return
			}
			
			if let responseString = String(data: data, encoding: .utf8) {
				print("Response: \(responseString)")
			}
			
			do {

				let vehicles = try JSONDecoder().decode([Vehicle].self, from: data)
				completion(.success(vehicles))
			} catch {
				
				completion(.failure(VehicleServiceError.decodingError(error)))
			}
		}.resume()
	}
}

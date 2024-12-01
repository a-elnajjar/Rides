//
//  NetworkManager.swift
//  Rides
//
//  Created by Abdalla Elnajjar on 2024-10-04.
//


import Foundation
import Combine

enum NetworkError: Error {
	case invalidURL
	case networkError(Error)
	case dataCorrupted
	case decodingError(Error)
}

class NetworkManager {
	static let shared = NetworkManager() // Singleton for global access
	private init() {} // Private initializer to prevent instantiation

	/// Generic API call function using Combine
	/// - Parameters:
	///   - urlString: The URL string for the request.
	///   - responseType: The type to decode the response into.
	/// - Returns: A publisher that emits the decoded response or an error.
	func fetchData<T: Decodable>(
		from urlString: String,
		responseType: T.Type
	) -> AnyPublisher<T, NetworkError> {
		guard let url = URL(string: urlString) else {
			return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
		}

		return URLSession.shared.dataTaskPublisher(for: url)
			.tryMap { data, _ -> T in
				do {
					return try JSONDecoder().decode(T.self, from: data)
				} catch {
					throw NetworkError.decodingError(error)
				}
			}
			.mapError { error -> NetworkError in
				if let networkError = error as? NetworkError {
					return networkError
				}
				return .networkError(error)
			}
			.eraseToAnyPublisher()
	}
}

//
//  VehicleListView.swift
//  Rides
//
//  Created by Abdalla Elnajjar on 2024-10-04.
//

import SwiftUI

struct VehicleListView: View {
	@StateObject private var viewModel = VehicleListViewModel()
	@State private var showAlert = false
	@State private var alertMessage = ""

	var body: some View {
		ZStack {
			NavigationView {
				VStack(spacing: 16) {
					// Input Field
					TextField("Enter number of vehicles (1-100)", text: $viewModel.inputCount)
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.keyboardType(.numberPad)
						.padding()

					// Fetch Button
					Button("Fetch Vehicles") {
						if let count = Int(viewModel.inputCount), (1...100).contains(count) {
							viewModel.fetchVehicles()
						} else {
							alertMessage = "Value must be an integer in the range 1 to 100."
							showAlert = true
						}
					}
					.frame(maxWidth: .infinity)
					.padding(.vertical, 12)
					.background(Color.blue)
					.foregroundStyle(.white)
					.clipShape(Capsule())
					.padding(.horizontal)
					.alert(isPresented: $showAlert) {
						Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
					}

					// Sort Picker
					VStack(alignment: .leading, spacing: 8) {
						Text("Sort By")
							.font(.subheadline)
							.foregroundColor(.gray)
						
						Picker("Sort Vehicles", selection: $viewModel.selectedSortOption) {
							ForEach(VehicleListViewModel.SortOption.allCases, id: \.self) { option in
								Text(option.rawValue).tag(option)
							}
						}
						.pickerStyle(.segmented)
					}
					.padding()

					// Vehicle List
					if viewModel.vehicles.isEmpty && !viewModel.isLoading {
						VStack(spacing: 12) {
							Image(systemName: "car.fill")
								.font(.largeTitle)
								.foregroundColor(.gray)
							Text("No Vehicles")
								.font(.headline)
							Text("Enter a count and tap Fetch to load vehicles")
								.font(.subheadline)
								.foregroundColor(.gray)
						}
						.frame(maxHeight: .infinity, alignment: .center)
					} else if !viewModel.vehicles.isEmpty {
						List(viewModel.vehicles, id: \.id) { vehicle in
							NavigationLink(destination: VehicleDetailView(vehicle: vehicle)) {
								VStack(alignment: .leading, spacing: 4) {
									Text(vehicle.makeAndModel)
										.font(.headline)
									Text("VIN: \(vehicle.vin)")
										.font(.caption)
										.foregroundColor(.gray)
								}
							}
						}
					}
				}
				.navigationTitle("Vehicles")
			}

			// Loading Overlay
			if viewModel.isLoading {
				ZStack {
					Color.black.opacity(0.3)
						.ignoresSafeArea()
					
					VStack(spacing: 12) {
						ProgressView()
						Text("Loading vehicles...")
							.foregroundColor(.primary)
					}
					.padding()
					.background(Color.white)
					.cornerRadius(10)
					.shadow(radius: 10)
				}
			}

			// Error Alert
			if let errorMessage = viewModel.errorMessage {
				ZStack {
					Color.black.opacity(0.3)
						.ignoresSafeArea()
					
					VStack(spacing: 12) {
						Image(systemName: "exclamationmark.circle.fill")
							.font(.largeTitle)
							.foregroundColor(.red)
						Text("Error")
							.font(.headline)
						Text(errorMessage)
							.font(.subheadline)
							.multilineTextAlignment(.center)
						
						Button("Dismiss") {
							viewModel.errorMessage = nil
						}
						.frame(maxWidth: .infinity)
						.padding(.vertical, 10)
						.background(Color.blue)
						.foregroundColor(.white)
						.cornerRadius(8)
					}
					.padding()
					.background(Color.white)
					.cornerRadius(10)
					.shadow(radius: 10)
				}
			}
		}
	}
}

#Preview {
	VehicleListView()
}

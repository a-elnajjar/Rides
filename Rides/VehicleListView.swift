//
//  VehicleListView.swift
//  Rides
//
//  Created by Abdalla Elnajjar on 2024-10-04.
//

import SwiftUI

import SwiftUI

struct VehicleListView: View {
	@StateObject private var viewModel = VehicleListViewModel()
	@State private var showAlert = false
	@State private var alertMessage = ""

	var body: some View {
		ZStack { // Use a ZStack to overlay the ProgressView
			NavigationView {
				VStack {
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
					.padding()
					.background(Color.blue)
					.foregroundStyle(.white)
					.clipShape(Capsule())
					.alert(isPresented: $showAlert) {
						Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
					}

					// Sort Picker
					Picker("Sort Vehicles", selection: $viewModel.selectedSortOption) {
						ForEach(VehicleListViewModel.SortOption.allCases, id: \.self) { option in
							Text(option.rawValue).tag(option)
						}
					}
					.pickerStyle(SegmentedPickerStyle())
					.padding()
					.onChange(of: viewModel.selectedSortOption) { _ in
						viewModel.sortVehicles()
					}

					// Vehicle List
					List(viewModel.vehicles, id: \.id) { vehicle in
						NavigationLink(destination: VehicleDetailView(vehicle: vehicle)) {
							VStack(alignment: .leading) {
								Text(vehicle.makeAndModel)
									.font(.headline)
								Text("VIN: \(vehicle.vin)")
							}
						}
					}
				}
				.navigationTitle("Vehicles")
			}

			// Overlay the ProgressView when loading
			if viewModel.isLoading {
				Color.black.opacity(0.3) // Optional: Dim the background
					.ignoresSafeArea()
				ProgressView("Loading...")
					.padding()
					.background(Color.white)
					.cornerRadius(10)
					.shadow(radius: 10)
			}
		}
	}
}





#Preview {
    VehicleListView()
}

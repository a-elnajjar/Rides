//
//  VehicleListView.swift
//  Rides
//
//  Created by Abdalla Elnajjar on 2024-10-04.
//

import SwiftUI

struct VehicleListView: View {
	@StateObject private var viewModel = VehicleListViewModel()

	var body: some View {
		NavigationView {
			VStack {
				TextField("Enter number of vehicles (1-100)", text: $viewModel.inputCount)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.keyboardType(.numberPad)
					.padding()

				Button("Fetch Vehicles") {
					viewModel.fetchVehicles()
				}
				.padding()

				VStack {
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
				}
				.padding()

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
	}
}



#Preview {
    VehicleListView()
}

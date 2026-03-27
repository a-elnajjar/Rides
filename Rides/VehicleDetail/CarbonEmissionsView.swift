//
//  CarbonEmissionsView.swift
//  Rides
//
//  Created by Abdalla Elnajjar on 2024-10-04.
//

import SwiftUI

struct CarbonEmissionsView: View {
	@StateObject private var viewModel : CarbonEmissionsViewModel
	
	
	init(vehicle:Vehicle){
		_viewModel = StateObject(wrappedValue: CarbonEmissionsViewModel(vehicle: vehicle))
	}

	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text("Estimated Carbon Emissions")
				.font(.title)
				.padding(.bottom)

			Text("Kilometrage: \(viewModel.vehicle.kilometrage) km")
			Text("Carbon Emissions: \(viewModel.emissions, specifier: "%.2f") units")
		}
		.applyCardStyle()
	}
}

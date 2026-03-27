//
//  VehicleInfoView.swift
//  Rides
//
//  Created by Abdalla Elnajjar on 2024-10-04.
//
import SwiftUI

struct VehicleInfoView: View {
	let vehicle: Vehicle

	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text(vehicle.makeAndModel)
				.font(.title)
				.padding(.bottom)

			Text("VIN: \(vehicle.vin)")
			Text("Type: \(vehicle.carType)")
			Text("Kilometrage: \(vehicle.kilometrage) km")
		}
		.applyCardStyle()
	}
}

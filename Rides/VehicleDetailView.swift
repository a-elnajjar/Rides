//
//  VehicleDetailView.swift
//  Rides
//
//  Created by Abdalla Elnajjar on 2024-10-04.
//

import SwiftUI

struct VehicleDetailView: View {
	let vehicle: Vehicle
	
	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 10) {
				Text("VIN: \(vehicle.vin)")
				Text("Make & Model: \(vehicle.makeAndModel)")
				Text("Color: \(vehicle.color)")
				Text("Car Type: \(vehicle.carType)")
			}
			.padding()
		}
		.navigationTitle("Vehicle Details")
	}
}


#Preview {
  //  VehicleDetailView()
}

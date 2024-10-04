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
		VStack {
			TabView {
				VehicleInfoView(vehicle: vehicle)
					.tag(0)
				
				CarbonEmissionsView(vehicle: vehicle)
					.tag(1)
			}
			.tabViewStyle(PageTabViewStyle())
			
			.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always)) 
		}
		.navigationTitle("Vehicle Details")
		.navigationBarTitleDisplayMode(.inline)
	}
}




#Preview {
  //  VehicleDetailView()
}

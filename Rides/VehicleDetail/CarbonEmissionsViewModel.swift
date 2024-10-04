//
//  CarbonEmissionsViewModel.swift
//  Rides
//
//  Created by Abdalla Elnajjar on 2024-10-04.
//


import Foundation

class CarbonEmissionsViewModel: ObservableObject {
    let vehicle: Vehicle

    init(vehicle: Vehicle) {
        self.vehicle = vehicle
    }

    var emissions: Double {
        calculateCarbonEmissions(kilometrage: vehicle.kilometrage)
    }

    private func calculateCarbonEmissions(kilometrage: Int) -> Double {
        if kilometrage <= 5000 {
            return Double(kilometrage)
        } else {
            let initialEmissions = 5000.0 * 1.0
            let additionalEmissions = Double(kilometrage - 5000) * 1.5
            return initialEmissions + additionalEmissions
        }
    }
}

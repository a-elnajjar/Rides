//
//  Vehicle.swift
//  Rides
//
//  Created by Abdalla Elnajjar on 2024-10-04.
//

import Foundation
struct Vehicle: Identifiable, Codable {
	let id: Int
	let uid: UUID
	let vin: String
	let makeAndModel, color: String
	let transmission: String
	let driveType: DriveType?
	let fuelType, carType: String
	let carOptions, specs: [String]
	let doors, mileage, kilometrage: Int
	let licensePlate: String

	enum CodingKeys: String, CodingKey {
		case id, uid, vin
		case makeAndModel = "make_and_model"
		case color, transmission
		case driveType = "drive_type"
		case fuelType = "fuel_type"
		case carType = "car_type"
		case carOptions = "car_options"
		case specs, doors, mileage, kilometrage
		case licensePlate = "license_plate"
	}
}


enum DriveType: String, Codable {
	case awd = "AWD"
	case the4X22WheelDrive = "4x2/2-wheel drive"
	case the4X44WheelDrive = "4x4/4-wheel drive"
	case rwd = "RWD"
	case fwd = "FWD"
	case unknown
}

//
//  CardStyleModifier.swift
//  Rides
//
//  Created by Abdalla Elnajjar on 2024-10-04.
//

import SwiftUI


struct CardStyleModifier: ViewModifier {
	func body(content: Content) -> some View {
		content
			.padding()
			.background(
				RoundedRectangle(cornerRadius: 10)
					.fill(Color.white)
					.shadow(color: .gray, radius: 5, x: 0, y: 5)
			)
			.padding()
	}
}


extension View {
	func applyCardStyle() -> some View {
		self.modifier(CardStyleModifier())
	}
}

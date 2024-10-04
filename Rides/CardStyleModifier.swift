//
//  CardStyleModifier.swift
//  Rides
//
//  Created by Abdalla Elnajjar on 2024-10-04.
//

import SwiftUI

// Create a ViewModifier to encapsulate the card style
struct CardStyleModifier: ViewModifier {
	func body(content: Content) -> some View {
		content
			.padding()
			.background(
				RoundedRectangle(cornerRadius: 10)
					.fill(Color.white)
					.shadow(color: .gray, radius: 5, x: 0, y: 5)
			)
			.padding() // Outer padding for spacing around the card
	}
}

// Create a View extension to make it easy to apply the modifier
extension View {
	func applyCardStyle() -> some View {
		self.modifier(CardStyleModifier())
	}
}

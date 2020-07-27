//
//  HomeScreenProfileClasses.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct HomeScreenClasses: View {
	@Binding var classes: [ClassResponse]
	@Binding var currentClass: Int
	
	func getDate(weekDay: Int) -> String {
		let cal = Calendar.current
		
		var comps = cal.dateComponents([.weekOfYear, .yearForWeekOfYear], from: Date())
		
		comps.weekday = weekDay
		var dayInWeek = cal.date(from: comps)!
		
		if weekDay == 0 {
			dayInWeek = cal.date(byAdding: .day, value: -7, to: dayInWeek)!
		}
		
		let df = DateFormatter()
		df.dateFormat = "dd/MM/yyyy"
		
		return df.string(from: dayInWeek)
		
	}
	
	func getCard(actualClass: ClassResponse, index: Int) -> some View {
		let dateFormatted = self.getDate(weekDay: index)
		
		return (
			VStack(alignment: actualClass.hasClass ? .leading : .center, spacing: 0) {
				HStack(alignment: .center, spacing: 0) {
					Spacer()
					Text("\(dateFormatted) - \(actualClass.weekDay)")
						.foregroundColor(Color(CustomColor.white))
						.font(.system(size: 14, weight: .medium))
					Spacer()
				}
				.padding(.vertical, 5)
				.background(Color(CustomColor.gray))
				
				if actualClass.hasClass {
					VStack(alignment: .leading, spacing: 2) {
						Text("\(actualClass.course)")
							.foregroundColor(Color(CustomColor.gray))
							.font(.system(size: 16, weight: .bold))
							.multilineTextAlignment(.leading)
						
						Text("\(actualClass.teacher)")
							.foregroundColor(Color(CustomColor.gray))
							.font(.system(size: 16, weight: .medium))
							.multilineTextAlignment(.leading)
					}
					.padding(.all, 10)
										
					HStack(alignment: .center) {
						Spacer()
						Text("\(actualClass.place)")
							.font(.system(size: 14, weight: .bold))
						Spacer()
					}
					.padding(.vertical, 10)
				}
					
				else {
					Text("Não havera aulas nesse dia")
						.font(.system(size: 20, weight: .bold))
						.foregroundColor(Color(CustomColor.gray))
						.padding(.top, 32)
						.padding(.bottom, 44)
				}
			}
			.border(Color.gray, width: 1)
			.padding()
		)
	}
	
	var body: some View {
		SlideHorizontal(
			classes.enumerated().map { (index, element) in self.getCard(actualClass: element, index: index) },
			hasDots: true,
			currentPage: self.$currentClass
		)
		.frame(height: 180)
	}
}

struct HomeScreenClasses_Previews: PreviewProvider {
	@State static var classes: [ClassResponse] = []
	@State static var currentClass: Int = 3
	
	static var previews: some View {
		HomeScreenClasses(classes: $classes, currentClass: $currentClass)
	}
}

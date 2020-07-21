//
//  MenuScreen.swift
//  Sims School
//
//  Created by João Damazio on 21/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import Firebase
 
struct MenuScreen: View {
	@ObservedObject var props = MenuScreenModel()
		
	var body: some View {
		VStack(alignment: .leading) {
			MenuScreenOptions(options: self.$props.options)
			Spacer()
			MenuScreenLogout()
		}
		.padding()
		.navigationBarTitle("Menu", displayMode: .inline)
		.frame(
			minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top
		)
	}
}

struct MenuScreen_Previews: PreviewProvider {
	static var previews: some View {
		MenuScreen()
	}
}

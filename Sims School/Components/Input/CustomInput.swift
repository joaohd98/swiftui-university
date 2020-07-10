//
//  CustomInputView.swift
//  swiftui-escola
//
//  Created by João Damazio on 01/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

fileprivate struct CustomTextField : TextFieldStyle {
	var input: FormInputModel
	var color: Color

	public func _body(configuration: TextField<Self._Label>) -> some View {
		configuration
			.padding(.vertical, 8)
			.padding(.horizontal, 10)
			.foregroundColor(CustomColor.inputColor)
			.font(.system(size: 13, weight: .medium, design: .rounded))
			.background(
				RoundedRectangle(cornerRadius: 10)
					.strokeBorder(self.color, lineWidth: 1)
			)
	}
}


struct CustomInput: View {
	@ObservedObject var input: FormInputModel
	
	func onAppear() {
		self.input.bindingValue = Binding<String>(get: {
			self.input.value
		}, set: {
			self.input.value = $0
			self.input.validationRule = FormRules.checkInputIsValid(input: self.input)
		})
	}
	
    var body: some View {
		let color = self.input.getColor()
		let message = color == CustomColor.danger ||  color == CustomColor.warning ? self.input.validationRule!.message : ""
		
		return (
			VStack(alignment: .leading, spacing: 2.0) {
				if self.input.isPassword {
					SecureField(input.placeholder, text: self.input.bindingValue!)
						.simultaneousGesture(TapGesture().onEnded { _ in
							self.input.changeFocus(true)
						})
					   .onReceive(NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification), perform: {_ in
							if self.input.hasFocus {
								self.input.changeFocus(false)
							}
						})
						.textFieldStyle(CustomTextField(input: self.input, color: color))
				}
				else {
					TextField(input.placeholder, text: self.input.bindingValue!, onEditingChanged: {hasFocus in self.input.changeFocus(hasFocus)})
						.keyboardType(self.input.keyboardType)
						.textFieldStyle(CustomTextField(input: self.input, color: color))
				}
		
				Text(message)
					.foregroundColor(color)
					.font(.system(size: 12, weight: .medium, design: .rounded))
					.padding(.horizontal, 7)
			}.padding(.horizontal, 7)
		)
		.onAppear{ self.onAppear() }
	}
	
}


struct CustomInputView_Previews: PreviewProvider {
    static var previews: some View {
		CustomInput(
			input: FormInputModel.init(name: "nome", placeholder: "Nome")
		)
		.previewLayout(.fixed(width: 300, height: 100))
    }
}
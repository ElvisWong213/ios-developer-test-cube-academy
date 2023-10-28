//
//  PrimaryButton.swift
//  Nominations
//
//  Created by Elvis on 26/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import SwiftUI
import CubeFoundationSwiftUI

struct PrimaryButton: View {
    let text: String
    let action: (() -> Void)
    
    @Environment(\.isEnabled) var isEnabled

    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .textCase(.uppercase)
                .foregroundStyle(.white)
                .font(TextStyle.button.font)
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(CustomButton())
        .padding()
    }
    
    struct CustomButton: ButtonStyle {
        @Environment(\.isEnabled) var isEnabled

        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .border(isEnabled ? .black : .cubeMidGrey, width: 2)
                .background(buttonColor(isPressed: configuration.isPressed))
        }
        
        func buttonColor(isPressed: Bool) -> Color {
            if !isEnabled {
                return .cubeMidGrey
            }
            if isPressed {
                return .cubeDarkGrey
            }
            return .black
        }
    }
}

#Preview {
    VStack {
        PrimaryButton(text: "Hello world") {
            
        }
        .disabled(true)
        PrimaryButton(text: "Hello world") {
            
        }
    }
}

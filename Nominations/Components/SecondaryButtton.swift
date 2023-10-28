//
//  SecondaryButtton.swift
//  Nominations
//
//  Created by Elvis on 26/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import SwiftUI
import CubeFoundationSwiftUI

struct SecondaryButtton: View {
    let text: String
    let action: (() -> Void)
        
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .textCase(.uppercase)
                .font(TextStyle.button.font)
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(CustomButtonStyle())
        .padding()
    }
    
    struct CustomButtonStyle: ButtonStyle {
        @Environment(\.isEnabled) var isEnabled

        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .background(.white)
                .foregroundStyle(isEnabled ? .black : .cubeDarkGrey)
                .border(buttonColor(isPressed: configuration.isPressed), width: 2)
        }
        
        func buttonColor(isPressed: Bool) -> Color {
            if !isEnabled {
                return .cubeMidGrey
            }
            if isPressed {
                return .accent
            }
            return .black
        }
    }
}

#Preview {
    VStack {
        SecondaryButtton(text: "Test") {
            
        }
        .disabled(true)
        SecondaryButtton(text: "Test") {
            
        }
    }
}

//
//  CustomButton.swift
//  Nominations
//
//  Created by Elvis on 26/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import SwiftUI
import CubeFoundationSwiftUI

/// Primary and Secondary button
struct CustomButton: View {
    let type: ButtonType
    let text: String
    var isLoading: Bool = false
    let action: (() -> Void)
    
    var body: some View {
        Button {
            action()
        } label: {
            Group {
                if isLoading {
                    // Show the loading circle when user submited the form and waiting for response
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: type.forgroundColor))
                } else {
                    Text(text)
                        .textCase(.uppercase)
                        .font(TextStyle.button.font)
                        .bold()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(PrimaryButtonStyle(type: type))
        .padding()
    }
    
    struct PrimaryButtonStyle: ButtonStyle {
        let type: ButtonType
        @Environment(\.isEnabled) var isEnabled

        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .border(buttonBorderColor(isPressed: configuration.isPressed), width: 2)
                .background(buttonBackgroundColor(isPressed: configuration.isPressed))
                .foregroundStyle(isEnabled ? type.forgroundColor : type.inactiveForgroundColor)
        }
        
        /// Button background color
        func buttonBackgroundColor(isPressed: Bool) -> Color {
            if !isEnabled {
                return type.inactiveBackgroundColor
            }
            if isPressed {
                return type.pressedBackgroundColor
            }
            return type.backgroundColor
        }
        
        /// Button border color
        func buttonBorderColor(isPressed: Bool) -> Color {
            if !isEnabled {
                return type.inactiveBorderColor
            }
            if isPressed {
                return type.pressedBorderColor
            }
            return type.borderColor
        }
    }
}

/// Button type with their color
enum ButtonType {
    case Primary, Secondary
    
    // MARK: - Background Color
    var backgroundColor: Color {
        switch self {
        case .Primary:
            return .black
        case .Secondary:
            return .white
        }
    }
    
    var inactiveBackgroundColor: Color {
        switch self {
        case .Primary:
            return .cubeMidGrey
        case .Secondary:
            return .white
        }
    }
    
    var pressedBackgroundColor: Color {
        switch self {
        case .Primary:
            return .cubeDarkGrey
        case .Secondary:
            return .white
        }
    }
    
    // MARK: - Forground Color
    var forgroundColor: Color {
        switch self {
        case .Primary:
            return .white
        case .Secondary:
            return .black
        }
    }
    
    var inactiveForgroundColor: Color {
        switch self {
        case .Primary:
            return .white
        case .Secondary:
            return .cubeDarkGrey
        }
    }
    
    // MARK: - Border Color
    var borderColor: Color {
        switch self {
        case .Primary, .Secondary:
            return .black
        }
    }
    
    var inactiveBorderColor: Color {
        switch self {
        case .Primary, .Secondary:
            return .cubeMidGrey
        }
    }
    
    var pressedBorderColor: Color {
        switch self {
        case .Primary:
            return .black
        case .Secondary:
            return .accent
        }
    }
}

#Preview {
    VStack {
        // MARK: - Primary
        // Active and Pressed
        CustomButton(type: .Primary, text: "Hello world", isLoading: false) {
            print("Button 1")
        }
        // Inactive
        CustomButton(type: .Primary, text: "Hello world", isLoading: false) {
            print("Button 2")
        }
        .disabled(true)
        // Loading
        CustomButton(type: .Primary, text: "Hello world", isLoading: true) {
            print("Button 3")
        }
        
        // MARK: - Secondary
        // Active and Pressed
        CustomButton(type: .Secondary, text: "Hello world", isLoading: false) {
            print("Button 1")
        }
        // Inactive
        CustomButton(type: .Secondary, text: "Hello world", isLoading: false) {
            print("Button 2")
        }
        .disabled(true)
        // Loading
        CustomButton(type: .Secondary, text: "Hello world", isLoading: true) {
            print("Button 3")
        }
    }
}

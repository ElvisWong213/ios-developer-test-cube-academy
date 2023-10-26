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
    
    @Environment(\.isEnabled) var isEnabled
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .textCase(.uppercase)
                .foregroundStyle(.black)
                .font(TextStyle.button.font)
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
                .border(.black, width: 2)
        }
        .background(.white)
        .padding()
    }
}

#Preview {
    SecondaryButtton(text: "Test") {
        
    }
}

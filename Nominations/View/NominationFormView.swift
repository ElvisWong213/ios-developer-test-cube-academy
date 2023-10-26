//
//  NominationFormView.swift
//  Nominations
//
//  Created by Elvis on 26/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import SwiftUI
import CubeFoundationSwiftUI

struct NominationFormView: View {
    @State var showAlert: Bool = false
    @State var reasoningText: String = "David always goes above and beyond with all the work that he does. He’s also a lovey person to work with!"
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HeaderBarView(title: "Create a nomination")
                ScrollView {
                    Image(.team)
                        .resizable()
                        .scaledToFit()
                    VStack(alignment: .leading) {
                        Text("I'd like to nominate...")
                            .textCase(.uppercase)
                            .font(TextStyle.boldHeadlineSmall.font)
                            .bold()
                        Text("Please select a cube who you fell has done someting honourable this month or just all round has a great work ethic.")
                            .font(TextStyle.body.font)
                        Text("Cube's name")
                            .font(TextStyle.boldHeadlineSmallest.font)
                            .bold()
                        Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                            /*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
                            /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
                        }
                        .pickerStyle(.menu)
                        Divider()
                        Text("I'd like to nominate this cube because...")
                            .textCase(.uppercase)
                            .font(TextStyle.boldHeadlineSmall.font)
                            .bold()
                        Text("Please let us know why you think this cube deserves the 'cub of the month' title 🏆⭐")
                            .font(TextStyle.body.font)
                        Text("Reasoning")
                            .font(TextStyle.boldHeadlineSmallest.font)
                            .bold()
                        TextEditor(text: $reasoningText)
                            .frame(height: 200)
                            .border(Color.black, width: 1)
                            .font(TextStyle.body.font)
                        Divider()
                        HStack {
                            Text("is how we currently run")
                                .bold() +
                            Text(" cube of the month ")
                                .foregroundStyle(.accent) +
                            Text("fair?")
                        }
                        .textCase(.uppercase)
                        .font(TextStyle.boldHeadlineSmall.font)
                        .bold()
                        Text("As you know, out the nominees chosen, we spin a wheel to pick the cube of the month. What's your opinion on this method?")
                            .font(TextStyle.body.font)
                        Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                            /*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
                            /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
                        }
                        .pickerStyle(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Picker Style@*/DefaultPickerStyle()/*@END_MENU_TOKEN@*/)
                    }
                    .padding()
                }
                HStack(spacing: 0) {
                    SecondaryButtton(text: "Back") {
                        showAlert.toggle()
                    }
                    PrimaryButton(text: "Submit nomination") {
                        
                    }
                    .frame(width: UIScreen.main.bounds.width / 3 * 2)
                }
                .customShadow()
            }
            VStack(spacing: 0) {
                Color(red: 0, green: 0, blue: 0, opacity: 0.8)
                LeavePageAlertView(showAlert: $showAlert)
                    .background(.white)
            }
            .opacity(showAlert ? 1 : 0)
        }
    }
}

#Preview {
    NominationFormView()
}

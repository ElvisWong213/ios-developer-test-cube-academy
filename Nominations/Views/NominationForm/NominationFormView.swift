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
    @EnvironmentObject var homeVM: HomeViewModel
    @State var showAlert: Bool = false
    @State var selectedNominee: String = ""
    @State var reasoningText: String = ""
    @State var selectedFeeling: FeelingKey?
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HeaderBarView(title: "Create a nomination")
                ScrollView {
                    Image(.team)
                        .resizable()
                        .scaledToFit()
                    VStack(alignment: .leading, spacing: 20) {
                        Text("I'd like to nominate...")
                            .textCase(.uppercase)
                            .font(TextStyle.boldHeadlineSmall.font)
                            .bold()
                        Text("Please select a cube who you fell has done someting honourable this month or just all round has a great work ethic.")
                            .font(TextStyle.body.font)
                        HStack {
                            Text("*")
                                .foregroundStyle(.accent) +
                            Text("Cube's name")
                        }
                        .font(TextStyle.boldHeadlineSmallest.font)
                        .bold()
                        Picker(selection: $selectedNominee, label: Text("Club's name")) {
                            Text("-- Pick a name --")
                                .tag("")
                            ForEach(homeVM.nomineeList, id: \.nomineeId) { nominee in
                                Text("\(nominee.firstName) \(nominee.lastName)")
                                    .tag(nominee.nomineeId)
                            }
                        }
                        .pickerStyle(.menu)
                        Divider()
                            .padding(.vertical)
                        Text("I'd like to nominate this cube because...")
                            .textCase(.uppercase)
                            .font(TextStyle.boldHeadlineSmall.font)
                            .bold()
                        Text("Please let us know why you think this cube deserves the 'cub of the month' title 🏆⭐")
                            .font(TextStyle.body.font)
                        HStack {
                            Text("*")
                                .foregroundStyle(.accent) +
                            Text("Reasoning")
                        }
                        .font(TextStyle.boldHeadlineSmallest.font)
                        .bold()
                        TextEditor(text: $reasoningText)
                            .frame(height: 200)
                            .border(Color.black, width: 1)
                            .font(TextStyle.body.font)
                            .onChange(of: reasoningText) {
                                reasoningText = String(reasoningText.prefix(280))
                            }
                        Divider()
                            .padding(.vertical)
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
                        FeelingPicker(selected: $selectedFeeling)
                    }
                    .padding()
                }
                HStack(spacing: 0) {
                    SecondaryButtton(text: "Back") {
                        if isAPartOffFieldsFilledOut() {
                            showAlert.toggle()
                        } else {
                            homeVM.createNewNomination = false
                        }
                    }
                    PrimaryButton(text: "Submit nomination") {
                        print("Submit")
                    }
                    .disabled(!isAllFieldsFilledOut())
                    .frame(width: UIScreen.main.bounds.width / 3 * 2)
                }
                .customShadow()
            }
            .sheet(isPresented: $showAlert) {
                LeavePageAlertView(showAlert: $showAlert)
                    .background(.white)
                    .presentationDetents([.fraction(0.5)])
            }
        }
    }
}

extension NominationFormView {
    func isAllFieldsFilledOut() -> Bool {
        if selectedFeeling != nil && !selectedNominee.isEmpty && !reasoningText.isEmpty {
            return true
        }
        return false
    }
    
    func isAPartOffFieldsFilledOut() -> Bool {
        if selectedFeeling != nil || !selectedNominee.isEmpty || !reasoningText.isEmpty {
            return true
        }
        return false
    }
}

#Preview {
    NominationFormView()
        .environmentObject(HomeViewModel())
}

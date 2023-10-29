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
    @StateObject var vm = NominationFormViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderBarView(title: "Create a nomination")
            ScrollView {
                Image(.team)
                    .resizable()
                    .scaledToFit()
                VStack(alignment: .leading) {
                    
                    // MARK: - Name
                    FormTextView(title: { Text("I'd like to nominate...") }, description: "Please select a cube who you fell has done someting honourable this month or just all round has a great work ethic.", fieldTitle: "Cube's name")
                    Picker(selection: $vm.nominationRequest.nomineeId, label: Text("Club's name")) {
                        Text("-- Pick a name --")
                            .tag("")
                        ForEach(homeVM.nomineeList, id: \.nomineeId) { nominee in
                            Text("\(nominee.firstName) \(nominee.lastName)")
                                .tag(nominee.nomineeId)
                        }
                    }
                    .pickerStyle(.menu)
                    Divider()
                        .background(.cubeDarkGrey)
                        .padding(.vertical)
                    
                    // MARK: - Reasoning
                    FormTextView(title: { Text("I'd like to nominate this cube because...") }, description: "Please let us know why you think this cube deserves the 'cub of the month' title 🏆⭐", fieldTitle: "Reasoning")
                    TextEditor(text: $vm.nominationRequest.reason)
                        .frame(height: 200)
                        .border(Color.black, width: 1)
                        .font(TextStyle.body.font)
                        // Max characters: 280
                        .onChange(of: vm.nominationRequest.reason) {
                            vm.nominationRequest.reason = String(vm.nominationRequest.reason.prefix(280))
                        }
                    Divider()
                        .background(.cubeDarkGrey)
                        .padding(.vertical)
                    
                    // MARK: - Feeling
                    FormTextView(title: {
                        // Text in same line, having difference text style or color
                        HStack {
                            Text("is how we currently run") +
                            Text(" cube of the month ")
                                .foregroundStyle(.accent) +
                            Text("fair?")
                        }
                    }, description: "As you know, out the nominees chosen, we spin a wheel to pick the cube of the month. What's your opinion on this method?", fieldTitle: "")
                    FeelingPicker(selected: $vm.nominationRequest.process)
                }
                .padding()
            }
            
            // MARK: - Bottom
            HStack(spacing: 0) {
                SecondaryButtton(text: "Back") {
                    if vm.nominationRequest.isAPartFilledOut {
                        vm.showSheet.toggle()
                    } else {
                        homeVM.path = []
                    }
                }
                PrimaryButton(text: "Submit nomination", isLoading: vm.isLoading) {
                    // Prevent user submit multiple times to the API, when they have bad internet connection
                    if vm.isLoading == false {
                        vm.isLoading = true
                        Task {
                            if let response = await vm.submitForm() {
                                homeVM.path.append(.Submitted)
                                homeVM.nominationlist.append(response.data)
                            } else {
                                vm.showAlert = true
                            }
                            vm.isLoading = false
                        }
                    }
                }
                .disabled(!vm.nominationRequest.isAllFilledOut)
                .frame(width: UIScreen.main.bounds.width / 3 * 2)
            }
            .customShadow()
        }
        .sheet(isPresented: $vm.showSheet) {
            LeavePageAlertView(showSheet: $vm.showSheet)
                .background(.white)
                .presentationDetents([.fraction(0.5)])
        }
        .alert("Unable to submit", isPresented: $vm.showAlert, actions: {
            
        }, message: {
            Text("Please Try again later")
        })
        .onDisappear() {
            vm.reset()
        }
    }
}

#Preview {
    NavigationStack {
        NominationFormView()
            .environmentObject(HomeViewModel())
    }
}

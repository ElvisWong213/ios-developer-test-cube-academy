//
//  HomeView.swift
//  Nominations
//
//  Created by Elvis on 26/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import SwiftUI
import CubeFoundationSwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        NavigationStack(path: $vm.path) {
            VStack(spacing: 0) {
                HeaderBarView()
                List {
                    NominationsHeaderView()
                        .listRowInsets(EdgeInsets())
                    if vm.nominationlist.isEmpty {
                        ListEmptyView()
                            .listRowInsets(EdgeInsets())
                    } else {
                        ForEach(vm.nominationlist, id: \.nominationId) { nomination in
                            if let name = vm.nomineeList.first(where: { $0.nomineeId == nomination.nomineeId }) {
                                NominationsListItem(name: "\(name.firstName) \(name.lastName)", reason: nomination.reason)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            vm.removeNominations(atOffsets: indexSet)
                        })
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    vm.getAllNominees()
                    vm.getAllNominations()
                }
                PrimaryButton(text: "create new nomination") {
                    vm.path.append(.NominationForm)
                }
                .customShadow()
                .navigationDestination(for: ViewEnum.self, destination: { view in
                    switch view {
                    case .Home:
                        HomeView()
                    case .NominationForm:
                        NominationFormView()
                            .navigationBarBackButtonHidden()
                    case .Submitted:
                        SubmittedView()
                            .navigationBarBackButtonHidden()
                    }
                })
                
            }
            .background(.cubeLightGrey)
        }
        .onAppear() {
            vm.getAllNominees()
            vm.getAllNominations()
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}

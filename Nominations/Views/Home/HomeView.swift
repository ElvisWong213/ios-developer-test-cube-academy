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
                if vm.nominationlist.isEmpty {
                    NominationsHeaderView()
                    ListEmptyView()
                } else {
                    List {
                        NominationsHeaderView()
                            .listRowInsets(EdgeInsets())
                        ForEach(vm.nominationlist, id: \.nominationId) { nomination in
                            if let name = vm.nomineeList.first(where: { $0.nomineeId == nomination.nomineeId }) {
                                NominationsListItem(name: "\(name.firstName) \(name.lastName)", reason: nomination.reason)
                            }
                        }
                    }
                    .listStyle(.plain)
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
        .refreshable {
            vm.getAllNominees()
            vm.getAllNominations()
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

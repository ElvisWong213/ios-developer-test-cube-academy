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
        NavigationStack {
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
                    vm.createNewNomination = true
                }
                .customShadow()
                .navigationDestination(isPresented: $vm.createNewNomination) {
                    NominationFormView()
                        .navigationBarBackButtonHidden()
                }
                
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

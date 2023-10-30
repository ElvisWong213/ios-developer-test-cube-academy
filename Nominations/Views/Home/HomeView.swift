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
                // MARK: - Body
                if vm.nominationlist.isEmpty {
                    GeometryReader { geo in
                        ListEmptyView(height: geo.size.height, isRefreshed: $vm.isRefreshed)
                    }
                } else {
                    List {
                        NominationsHeaderView()
                            .listRowInsets(EdgeInsets())
                        ForEach(vm.nominationlist, id: \.nominationId) { nomination in
                            if let name = vm.nomineeList.first(where: { $0.nomineeId == nomination.nomineeId }) {
                                NominationsListItem(name: "\(name.firstName) \(name.lastName)", reason: nomination.reason)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            vm.removeNomination(atOffsets: indexSet)
                        })
                    }
                    .listStyle(.plain)
                    .refreshable {
                        vm.fetchData()
                    }
                }
                // MARK: - Bottom
                CustomButton(type: .Primary, text: "create new nomination") {
                    vm.path.append(.NominationForm)
                }
                .customShadow()
                // MARK: - This control navigatio of all the view
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
        
        // MARK: - Get and refresh data from API
        .onAppear() {
            vm.fetchData()
        }
        .onChange(of: vm.isRefreshed) {
            if vm.isRefreshed {
                vm.fetchData()
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}

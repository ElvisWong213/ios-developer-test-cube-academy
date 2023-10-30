//
//  HomeViewModel.swift
//  Nominations
//
//  Created by Elvis on 28/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var nominationlist: [NominationResponse] = []
    @Published var nomineeList: [Nominee] = []
    @Published var path: [ViewEnum] = []
    @Published var isRefreshed = false
    
    /// Get Nominations from API
    private func getAllNominations() async {
        guard let response = try? await Network.makeRequest(request: .getAllNominations) as AllNominationsResponse else {
            return
        }
        nominationlist = response.data
    }
    
    /// Get Nominees from API
    private func getAllNominees() async {
        guard let response = try? await Network.makeRequest(request: .getAllNominees) as AllNominees else {
            return
        }
        nomineeList = response.data
    }
    
    /// Send delete nomination request
    func removeNomination(atOffsets: IndexSet) {
        Task {
            for index in atOffsets {
                guard let response = try? await Network.makeRequest(request: .deleteNomination(nominationId: nominationlist[index].nominationId)) as DeleteNominationResponse else {
                    print("Fail to remove")
                    return
                }
                print(response.data)
                nominationlist.remove(atOffsets: atOffsets)
            }
        }
    }
    
    /// Fetch all data
    func fetchData() {
        Task {
            await getAllNominees()
            await getAllNominations()
            isRefreshed = false
        }
    }
}

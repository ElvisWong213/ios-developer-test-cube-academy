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
    
    func getAllNominations() {
        Task {
            guard let response = try? await Network.makeRequest(request: .getAllNominations) as AllNominationsResponse else {
                return
            }
            nominationlist = response.data
        }
    }
    
    func getAllNominees() {
        Task {
            guard let response = try? await Network.makeRequest(request: .getAllNominees) as AllNominees else {
                return
            }
            nomineeList = response.data
        }
    }
}

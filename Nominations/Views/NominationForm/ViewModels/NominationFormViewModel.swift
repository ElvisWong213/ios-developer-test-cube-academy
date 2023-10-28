//
//  NominationFormViewModel.swift
//  Nominations
//
//  Created by Elvis on 28/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import Foundation

class NominationFormViewModel: ObservableObject {
    @Published var showAlert: Bool = false
    @Published var nominationRequest: NominationRequest = NominationRequest(nomineeId: "", reason: "", process: .Null)
    
    func reset() {
        showAlert = false
        nominationRequest = NominationRequest(nomineeId: "", reason: "", process: .Null)
    }
    
    func submitForm() async -> CreateNominationResponse? {
        guard nominationRequest.isAllFilledOut else { return nil }
        
        return try? await Network.makeRequest(request: .createNomination(nominationRequest: nominationRequest)) as CreateNominationResponse
    }
}

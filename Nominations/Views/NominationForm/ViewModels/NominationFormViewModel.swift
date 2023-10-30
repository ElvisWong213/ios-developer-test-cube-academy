//
//  NominationFormViewModel.swift
//  Nominations
//
//  Created by Elvis on 28/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import Foundation

class NominationFormViewModel: ObservableObject {
    @Published var showSheet: Bool = false
    @Published var nominationRequest: NominationRequest = NominationRequest(nomineeId: "", reason: "", process: .Null)
    @Published var showAlert = false
    @Published var isLoading = false
    
    /// Reset all
    func reset() {
        showSheet = false
        nominationRequest = NominationRequest(nomineeId: "", reason: "", process: .Null)
        showAlert = false
        isLoading = false
    }
    
    /// Submit new nomination
    /// - Returns: response from API
    func submitForm() async -> CreateNominationResponse? {
        guard nominationRequest.isAllFilledOut else { return nil }
        
        // Create a task
        let task = Task {
            let taskResult = try? await Network.makeRequest(request: .createNomination(nominationRequest: nominationRequest)) as CreateNominationResponse
            try? Task.checkCancellation()
            return taskResult
        }
        
        // Timeout after 5 second
        let timeoutTask = Task {
            try await Task.sleep(nanoseconds: 5000000000)
            task.cancel()
        }
        
        let result = await task.value
        timeoutTask.cancel()
        return result
    }
}

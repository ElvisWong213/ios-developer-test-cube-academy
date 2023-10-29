//
//  Network.swift
//  Nominations
//
//  Created by Elvis on 27/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import Foundation

class Network {
    static func makeRequest<T: Codable>(request: RestEnum) async throws -> T {
        // If url is nil throw error
        guard let url = URL(string: request.baseURL + request.path) else {
            throw NetworkError.InvalidURL
        }
        // If there is not token throw error
        guard let token = Network.getToken() else {
            throw NetworkError.InvalidToken
        }
        
        // Setup requset with url
        var urlRequest = URLRequest(url: url)
        // Define request method
        urlRequest.httpMethod = request.method
        // Add token
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        // Add data to requset when method is POST
        if request.method == "POST" {
            guard let data = request.data else {
                throw NetworkError.InvalidData
            }
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = data
//            print(String(decoding: data, as: UTF8.self))
        }
        
        // Send requset
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        // If respone is invalid throw error
        guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            print(response)
            throw NetworkError.InvalidResponse
        }
        
        // Decode data
        let decoded = try JSONDecoder().decode(T.self, from: data)
        return decoded
    }
    
    /// Take token from info.plist
    static func getToken() -> String? {
        guard let filePath = Bundle.main.path(forResource: "AuthToken", ofType: "plist") else {
            return nil
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "token") as? String else {
            print("Couldn't find key 'token' in 'AuthToken.plist'")
            return nil
        }
        return value
    }
}


enum NetworkError: LocalizedError {
    case InvalidResponse, InvalidURL, InvalidToken, InvalidData
}

enum RestEnum {
    // Nominee
    case getAllNominees
    
    // Nomination
    case getAllNominations
    case getNominationById(nominationId: String)
    case createNomination(nominationRequest: NominationRequest)
    case updateNomination(nominationId: String, nominationRequest: NominationRequest)
    case deleteNomination(nominationId: String)
}

extension RestEnum {
    
    // Requset method
    var method: String {
        switch self {
        case .getAllNominees, .getAllNominations, .getNominationById:
            return "GET"
        case .createNomination:
            return "POST"
        case .updateNomination:
            return "PUT"
        case .deleteNomination:
            return "DELETE"
        }
    }
    
    // API base url
    var baseURL: String {
        get {
            return "https://cube-academy-api.cubeapis.com/api/"
        }
    }
    
    // API path
    var path: String {
        switch self {
        case .getAllNominees:
            return "nominee"
        case .getAllNominations:
            return "nomination"
        case .getNominationById(nominationId: let nomination_id):
            return "nomination/\(nomination_id)"
        case .createNomination:
            return "nomination"
        case .updateNomination(nomination_id: let nomination_id):
            return "nomination/\(nomination_id)"
        case .deleteNomination(nominationId: let nomination_id):
            return "nomination/\(nomination_id)"
        }
    }
    
    // Encode json data
    var data: Data? {
        switch self {
        case .getAllNominees:
            return nil
        case .getAllNominations:
            return nil
        case .getNominationById:
            return nil
        case .createNomination(nominationRequest: let nominationRequest):
            guard nominationRequest.isAllFilledOut else {
                return nil
            }
            guard let data = try? JSONEncoder().encode(nominationRequest) else {
                return nil
            }
            return data
        case .updateNomination(nominationId: _, nominationRequest: let nominationRequest):
            guard let data = try? JSONEncoder().encode(nominationRequest) else {
                return nil
            }
            return data
        case .deleteNomination(nominationId: _):
            return nil
        }
    }
}

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
        guard let url = URL(string: request.baseURL + request.path) else {
            throw NetworkError.InvalidURL
        }
        guard let token = Network.getToken() else {
            throw NetworkError.InvalidToken
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        if request.method == "POST" {
            guard let data = request.data else {
                throw NetworkError.InvalidData
            }
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = data
//            print(String(decoding: data, as: UTF8.self))
        }
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            print(response)
            throw NetworkError.InvalidResponse
        }
        let decoded = try JSONDecoder().decode(T.self, from: data)
        return decoded
    }
    
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
    
    var baseURL: String {
        get {
            return "https://cube-academy-api.cubeapis.com/api/"
        }
    }
    
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
    
    var data: Data? {
        switch self {
        case .getAllNominees:
            return nil
        case .getAllNominations:
            return nil
        case .getNominationById:
            return nil
        case .createNomination(nominationRequest: let nominationRequest):
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

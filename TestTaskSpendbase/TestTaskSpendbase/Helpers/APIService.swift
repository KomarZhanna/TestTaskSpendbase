//
//  APIService.swift
//  TestTaskSpendbase
//
//  Created by Zhanna Komar on 04.06.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingFailed
}

class APIService {
    static let shared = APIService()
    
    private init() {}
    
    private func fetchData<T: Codable>(from urlString: String, mockResponse: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        guard let data = mockResponse.data(using: .utf8) else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingFailed
        }
    }
    
    func getTotalBalance(teamId: String) async throws -> TotalBalance {
        let url = "https://api.example.com/cards/account/total-balance?teamId=\(teamId)"
        let mockResponse = """
        {
            "balance": 153000.85
        }
        """
        return try await fetchData(from: url, mockResponse: mockResponse)
    }
    
    func getCards(teamId: String) async throws -> [Card] {
        let url = "https://api.example.com/cards?teamId=\(teamId)"
        let mockResponse = """
        [
            {
                "id": "1",
                "cardLast4": "4141",
                "cardName": "Virtual card",
                "isLocked": false,
                "isTerminated": false,
                "spent": 500,
                "limit": 2000,
                "limitType": "PerMonth",
                "cardHolder": {
                    "id": "1",
                    "fullName": "John Doe",
                    "email": "john@example.com",
                    "logoUrl": ""
                },
                "fundingSource": "ACH",
                "issuedAt": "2024-05-06T08:24:49.897Z"
            },
            {
                "id": "2",
                "cardLast4": "4141",
                "cardName": "Slack",
                "isLocked": false,
                "isTerminated": false,
                "spent": 500,
                "limit": 2000,
                "limitType": "PerMonth",
                "cardHolder": {
                    "id": "1",
                    "fullName": "John Doe",
                    "email": "john@example.com",
                    "logoUrl": ""
                },
                "fundingSource": "ACH",
                "issuedAt": "2024-05-06T08:24:49.897Z"
            },
            {
                "id": "3",
                "cardLast4": "4141",
                "cardName": "Google",
                "isLocked": false,
                "isTerminated": false,
                "spent": 500,
                "limit": 2000,
                "limitType": "PerMonth",
                "cardHolder": {
                    "id": "1",
                    "fullName": "John Doe",
                    "email": "john@example.com",
                    "logoUrl": ""
                },
                "fundingSource": "ACH",
                "issuedAt": "2024-05-06T08:24:49.897Z"
            }
        ]
        """
        return try await fetchData(from: url, mockResponse: mockResponse)
    }
    
    func getTransactions(teamId: String) async throws -> [Transaction] {
        let url = "https://api.example.com/cards/transactions?teamId=\(teamId)"
        let mockResponse = """
        [
            {
                "id": "1",
                "tribeTransactionId": "tx1",
                "tribeCardId": 1,
                "amount": "€1000",
                "status": "Completed",
                "tribeTransactionType": "Load",
                "schemeId": "scheme1",
                "merchantName": "Load",
                "pan": "123456******1234"
            },
            {
                "id": "2",
                "tribeTransactionId": "tx1",
                "tribeCardId": 1,
                "amount": "-€500",
                "status": "CompletedWithoutReceipt",
                "tribeTransactionType": "Purchase",
                "schemeId": "scheme1",
                "merchantName": "Google",
                "pan": "123456******1234"
            },
            {
                "id": "3",
                "tribeTransactionId": "tx1",
                "tribeCardId": 1,
                "amount": "-€1,299",
                "status": "Failed",
                "tribeTransactionType": "Purchase",
                "schemeId": "scheme1",
                "merchantName": "Google",
                "pan": "123456******1234"
            }
        ]
        """
        return try await fetchData(from: url, mockResponse: mockResponse)
    }
}

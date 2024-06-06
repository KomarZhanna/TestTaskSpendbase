//
//  Transaction.swift
//  TestTaskSpendbase
//
//  Created by Zhanna Komar on 04.06.2024.
//

import Foundation

enum TransactionStatus: String {
    case completed = "Completed"
    case failed = "Failed"
    case completedWithoutReceipt = "CompletedWithoutReceipt"
}

struct Transaction: Codable, Identifiable {
    let id: String
    let tribeTransactionId: String
    let tribeCardId: Int
    let amount: String
    let status: String
    let tribeTransactionType: String
    let schemeId: String
    let merchantName: String
    let pan: String
}

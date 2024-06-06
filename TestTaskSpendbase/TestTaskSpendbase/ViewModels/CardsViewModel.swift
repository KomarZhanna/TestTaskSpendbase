//
//  CardsViewModel.swift
//  TestTaskSpendbase
//
//  Created by Zhanna Komar on 04.06.2024.
//

import Foundation

class CardsViewModel: ObservableObject {
    @Published var totalBalance: TotalBalance?
    @Published var cards: [Card] = []
    @Published var transactions: [Transaction] = []
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiService = APIService.shared
    
    func loadData() async {
        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = nil
        }
        let teamId = "1111"
        do {
            async let balance = apiService.getTotalBalance(teamId: teamId)
            async let cards = apiService.getCards(teamId: teamId)
            async let transactions = apiService.getTransactions(teamId: teamId)
            
            let fetchedBalance = try await balance
            let fetchedCards = try await cards
            let fetchedTransactions = try await transactions
            
            DispatchQueue.main.async {
                self.totalBalance = fetchedBalance
                self.cards = fetchedCards
                self.transactions = fetchedTransactions
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}


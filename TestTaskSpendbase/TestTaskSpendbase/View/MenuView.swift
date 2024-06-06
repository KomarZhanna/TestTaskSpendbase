//
//  MenuView.swift
//  TestTaskSpendbase
//
//  Created by Zhanna Komar on 04.06.2024.
//
import SwiftUI

struct MenuView: View {
    @StateObject private var viewModel = CardsViewModel()
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    if let balance = viewModel.totalBalance {
                        totalBalanceView(balance: balance)
                    }
                    
                    cardsSection()
                    
                    transactionsSection()
                }
                .padding()
            }
            .background(Color("background"))
            .navigationTitle("Money")
            .navigationBarItems(trailing: addButton)
            .sheet(isPresented: $showingSheet) {
                WithdrawView()
            }
            .task {
                await viewModel.loadData()
            }
        }
    }
    
    private var addButton: some View {
        Button(action: {
            showingSheet.toggle()
        }) {
            Image(systemName: "plus")
        }
    }
    
    private func totalBalanceView(balance: TotalBalance) -> some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image("euro")
                    Text("EUR account")
                        .font(.custom("SF Pro", size: 15))
                        .foregroundColor(.gray)
                }
                HStack {
                    Text(viewModel.totalBalance?.balance.formatted(.currency(code: "EUR").locale(Locale(identifier: "en_US"))) ?? "")
                        .font(.largeTitle)
                        .bold()
                }
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private func cardsSection() -> some View {
        VStack {
            Section(header: sectionHeader(title: "My cards", action: "See All")) {
                VStack {
                    ForEach(viewModel.cards) { card in
                        HStack {
                            CardNumberView(cardNumber: card.cardLast4)
                            Text(card.cardName)
                                .font(.custom("SF Pro", size: 15))
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    }
                }
            }
        }
        .padding(.top)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private func transactionsSection() -> some View {
        VStack {
            Section(header: sectionHeader(title: "Recent transactions", action: "See All")) {
                VStack(spacing: 10) {
                    ForEach(viewModel.transactions) { transaction in
                        transactionRow(transaction: transaction)
                    }
                }
            }
        }
        .padding(.top)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private func transactionRow(transaction: Transaction) -> some View {
        HStack {
            Circle()
                .fill(Color("background"))
                .frame(width: 40, height: 40)
                .overlay(transactionIcon(transaction: transaction))
                .overlay(statusOverlay(for: transaction)
                    .offset(x: 28, y: 28.5),
                         alignment: .bottomTrailing
                )
            
            VStack(alignment: .leading) {
                Text(transaction.merchantName)
                    .font(.custom("SF Pro", size: 15))
                    .foregroundColor(Color("card"))
                Text("•• 7544")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(transaction.amount)
                .foregroundColor(textColorForAmount(transaction))
                .font(.headline)
            
            Image("receiptNotAdded")
                .opacity(transaction.status == TransactionStatus.completedWithoutReceipt.rawValue ? 1 : 0)
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
    
    private func transactionIcon(transaction: Transaction) -> some View {
        Group {
            if transaction.amount.contains("-") {
                Image("creditCard")
                    .foregroundColor(Color("card"))
                    .padding(10)
                    .cornerRadius(8)
            } else {
                Image(systemName: "arrow.down.left")
                    .foregroundColor(Color("card"))
                    .padding(10)
                    .cornerRadius(8)
            }
        }
    }
    
    private func statusOverlay(for transaction: Transaction) -> some View {
        Circle()
            .size(CGSize(width: 12, height: 12))
            .foregroundColor(transaction.status == "Failed" ? Color("redWarning") : .clear)
    }
    
    private func sectionHeader(title: String, action: String) -> some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            Spacer()
            Button(action: {
                // Action for see all
            }) {
                Text(action)
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
        }
        .padding(.horizontal)
        .background(Color.white)
    }
    
    private func textColorForAmount(_ transaction: Transaction) -> Color {
        switch (transaction.status, transaction.amount.contains("-")) {
        case (TransactionStatus.completed.rawValue, true), (TransactionStatus.completedWithoutReceipt.rawValue, true):
            return .black
        case (TransactionStatus.failed.rawValue, true):
            return .gray
        case (TransactionStatus.completed.rawValue, false), (TransactionStatus.completedWithoutReceipt.rawValue, false):
            return .green
        default:
            return .black
        }
    }
}

#Preview {
    MenuView()
}

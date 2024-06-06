//
//  WithdrawalView.swift
//  TestTaskSpendbase
//
//  Created by Zhanna Komar on 05.06.2024.
//

import SwiftUI

struct WithdrawView: View {
    @State private var amount: String = ""
    @State private var decimalAmount: Decimal?
    @StateObject private var viewModel = CardsViewModel()
    @FocusState private var keyboardFocused: Bool
    @Environment(\.dismiss) var dismiss

    var formattedBalance: String {
        return viewModel.totalBalance?.balance.formatted(.currency(code: "EUR").locale(Locale(identifier: "en_US"))) ?? ""
    }
    
    var attributedBalanceText: AttributedString {
        var attributedString = AttributedString("You have \(formattedBalance) available in your balance")
        
        if let balanceRange = attributedString.range(of: formattedBalance) {
            attributedString[balanceRange].foregroundColor = .black
        }
        
        let otherTextRanges = [
            attributedString.range(of: "You have "),
            attributedString.range(of: " available in your balance")
        ]
        
        for range in otherTextRanges {
            if let range = range {
                attributedString[range].foregroundColor = .gray
            }
        }
        
        return attributedString
    }
    
    var isAmountValid: Bool {
        guard let balance = viewModel.totalBalance?.balance,
              let decimalAmount else { return false }
        return decimalAmount <= Decimal(balance) && decimalAmount > 0
    }
    
    var body: some View {
        VStack {
            headerView()
            
            Spacer()
            
            amountInputView()
            
            Spacer()
            
            continueButton()
            
            Spacer()
        }
        .padding()
        .task {
            await viewModel.loadData()
        }
    }
    
    private func headerView() -> some View {
        HStack {
            Spacer()
            
            Text("Transfer")
                .font(.custom("SF Pro", size: 17).weight(.semibold))
                .bold()
            
            Spacer()
            
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.black)
            }
            .padding(.trailing)
        }
        .padding()
    }
    
    private func amountInputView() -> some View {
        VStack {
            HStack(spacing: 7.5) {
                Text("€")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 34, weight: .bold, design: .default))
                TextField("0", text: $amount)
                    .keyboardType(.decimalPad)
                    .numbersOnly($amount, includeDecimal: true)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 34, weight: .bold, design: .default))
                    .padding([.top, .bottom, .trailing])
                    .frame(minWidth: 40 , maxWidth: 160)
                    .focused($keyboardFocused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            keyboardFocused = true
                        }
                    }
                    .onChange(of: amount) { _, newValue in
                        guard let decimalValue = Decimal(string: newValue.replacingOccurrences(of: ",", with: ".")) else {
                            decimalAmount = nil
                            return
                        }
                        decimalAmount = decimalValue
                    }
            }
            .fixedSize(horizontal: true, vertical: false)
            
            if !isAmountValid && decimalAmount != nil {
                Text("You only have \(formattedBalance) available in your balance")
                    .font(.custom("SF Pro", size: 13))
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            } else {
                Text(attributedBalanceText)
                    .font(.custom("SF Pro", size: 13))
                    .bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding(.top, 5)
            }
        }
        .padding([.leading, .trailing], 99)
    }
    
    private func continueButton() -> some View {
        Button(action: {
            dismiss()
            print("Continue button pressed")
        }) {
            Text("Continue")
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
        }
        .disabled(!isAmountValid)
        .background(isAmountValid ? Color.blue : Color("disabledButton"))
        .cornerRadius(35)
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    WithdrawView()
}

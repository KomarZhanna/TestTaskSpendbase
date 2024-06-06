//
//  CardNumberView.swift
//  TestTaskSpendbase
//
//  Created by Zhanna Komar on 04.06.2024.
//

import SwiftUI

struct CardNumberView: View {
    var cardNumber: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color("card"))
            .frame(width: 48, height: 32)
            .overlay(
                Text(cardNumber)
                    .font(.custom("Inter", size: 10))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding([.bottom, .trailing], 5),
                                   alignment: .bottomTrailing
            )
    }
}

#Preview {
    CardNumberView(cardNumber: "4141")
}

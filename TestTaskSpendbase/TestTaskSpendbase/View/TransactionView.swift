//
//  TransactionView.swift
//  TestTaskSpendbase
//
//  Created by Zhanna Komar on 04.06.2024.
//

import SwiftUI

struct TransactionView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("placeholder")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(Color("lightText"))
                Text("Coming soon")
                    .font(.custom("SF Pro", size: 15))
                    .foregroundColor(Color("lightText"))
            }
            .navigationTitle("Transactions")
        }
    }
}

#Preview {
    TransactionView()
}

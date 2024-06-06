//
//  MainTabView.swift
//  TestTaskSpendbase
//
//  Created by Zhanna Komar on 04.06.2024.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MenuView()
                .tabItem {
                    Image("house")
                        .tint(.gray)
                    Text("Menu")
                }
            
            TransactionView()
                .tabItem {
                    Label("Transactions", systemImage: "list.dash")
                }
            
            MyCardsView()
                .tabItem {
                    Label("My Cards", image: "creditCard")
                }
            
            AccountView()
                .tabItem {
                    Label("Account", image: "account")
                }
        }
        .accentColor(.blue)
    }
}

#Preview {
    MainTabView()
}

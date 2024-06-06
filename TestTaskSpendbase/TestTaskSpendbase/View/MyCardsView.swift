//
//  MyCardsView.swift
//  TestTaskSpendbase
//
//  Created by Zhanna Komar on 04.06.2024.
//

import SwiftUI

struct MyCardsView: View {
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
            .navigationTitle("My Cards")
            .navigationBarItems(trailing: Button(action: {
                // Action for plus button
            }) {
                Image(systemName: "plus")
            })
        }
    }
}

#Preview {
    MyCardsView()
}

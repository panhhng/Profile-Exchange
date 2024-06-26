//
//  CustomInfoPopup.swift
//  profile-exchange
//
//  Created by Nhân Nguyễn on 6/26/24.
//

import SwiftUI

struct CustomInfoPopup: View {
    @Binding var showPopup: Bool
    @Binding var sharedInfoList: [BusinessCard]
    @State private var customName: String = ""
    @State private var customInfo: String = ""

    var body: some View {
        VStack {
            Text("Select info to share")
                .font(.headline)
                .padding()

            TextField("Name", text: $customName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Info", text: $customInfo)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                sharedInfoList.append(BusinessCard(name: customName, info: customInfo))
                showPopup = false
            }) {
                Text("Share")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

//
//  SharePopup.swift
//  profile-exchange
//
//  Created by Nhân Nguyễn on 6/26/24.
//

import SwiftUI

struct SharePopup: View {
    @Binding var showPopup: Bool
    @Binding var showCustomInfoPopup: Bool
    @Binding var sharedInfoList: [BusinessCard]
    var defaultProfile: Profile

    var body: some View {
        VStack {
            Text("Share info to phone ABC?")
                .font(.headline)
                .padding()

            HStack {
                Button(action: {
                    let defaultInfo = """
                    Name: \(defaultProfile.firstName) \(defaultProfile.lastName)
                    Facebook: \(defaultProfile.facebook)
                    LinkedIn: \(defaultProfile.linkedin)
                    Gmail: \(defaultProfile.gmail)
                    """
                    sharedInfoList.append(BusinessCard(name: "\(defaultProfile.firstName) \(defaultProfile.lastName)", info: defaultInfo))
                    showPopup = false
                }) {
                    Text("Share default info")
                }
                .padding()

                Button(action: {
                    showCustomInfoPopup = true
                    showPopup = false
                }) {
                    Text("Share custom info")
                }
                .padding()

                Button(action: {
                    showPopup = false
                }) {
                    Text("Cancel")
                }
                .padding()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}



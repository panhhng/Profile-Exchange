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
    @State private var includeFacebook: Bool = false
    @State private var includeLinkedIn: Bool = false
    @State private var includeGmail: Bool = false
    @State private var facebook: String = ""
    @State private var linkedin: String = ""
    @State private var gmail: String = ""

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

            Toggle(isOn: $includeFacebook) {
                Text("Include Facebook")
            }
            .padding()
            if includeFacebook {
                TextField("Facebook", text: $facebook)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }

            Toggle(isOn: $includeLinkedIn) {
                Text("Include LinkedIn")
            }
            .padding()
            if includeLinkedIn {
                TextField("LinkedIn", text: $linkedin)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }

            Toggle(isOn: $includeGmail) {
                Text("Include Gmail")
            }
            .padding()
            if includeGmail {
                TextField("Gmail", text: $gmail)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }

            HStack {
                Button(action: {
                    var info = customInfo
                    if includeFacebook {
                        info += "\nFacebook: \(facebook)"
                    }
                    if includeLinkedIn {
                        info += "\nLinkedIn: \(linkedin)"
                    }
                    if includeGmail {
                        info += "\nGmail: \(gmail)"
                    }
                    sharedInfoList.append(BusinessCard(name: customName, info: info))
                    showPopup = false
                }) {
                    Text("Share")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                Button(action: {
                    showPopup = false
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .padding()
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}






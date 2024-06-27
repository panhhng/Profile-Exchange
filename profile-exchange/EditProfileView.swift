//
//  EditProfileView.swift
//  profile-exchange
//
//  Created by Nhân Nguyễn on 6/26/24.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Binding var profile: Profile
    @Binding var profileImage: UIImage?
    @Binding var showPopup: Bool
    @State private var showImagePicker = false
    @State private var showUpdateMessage = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Picture")) {
                    if let profileImage = profileImage {
                        Image(uiImage: profileImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .clipped()
                    } else {
                        Text("No Image Selected")
                            .frame(height: 200)
                    }
                    Button("Select Profile Picture") {
                        showImagePicker = true
                    }
                }
                Section(header: Text("Name")) {
                    TextField("First Name", text: $profile.firstName)
                    TextField("Last Name", text: $profile.lastName)
                }
                Section(header: Text("Contact Info")) {
                    TextField("Facebook", text: $profile.facebook)
                    TextField("LinkedIn", text: $profile.linkedin)
                    TextField("Gmail", text: $profile.gmail)
                }
            }
            
            .navigationBarTitle("Edit Profile", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                showUpdateMessage = true
            })
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $profileImage)
            }
            .popup(isPresented: $showUpdateMessage) {
                VStack {
                    Text("You have updated your profile.")
                        .font(.headline)
                        .padding()
                    Button("OK") {
                        showUpdateMessage = false
                        showPopup = false
                    }
                    .padding()
                }
            }
        }
    }
}


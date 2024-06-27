//
//  ContentView.swift
//  profile-exchange
//
//  Created by Nhân Nguyễn on 6/26/24.
//

//import SwiftUI
//import CoreNFC
//
//struct ContentView: View {
//    // coi profile popup thì set showSharePopup thành true
//    @State private var showSharePopup = true
//    @State private var showCustomInfoPopup = false
//    @State private var showEditProfile = false
//    @State private var sharedInfoList: [BusinessCard] = []
//    @State private var defaultProfile = Profile()
//    @State private var profileImage: UIImage?
//    @State private var showImagePicker = false
//
//    var body: some View {
//        ZStack {
//            if let image = profileImage {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFill()
//                    .edgesIgnoringSafeArea(.all)
//                    .aspectRatio(contentMode: .fill)
//            } else {
//                Color.white.edgesIgnoringSafeArea(.all)
//            }
//
//            VStack {
//                List {
//                    ForEach(sharedInfoList) { card in
//                        HStack {
//                            VStack(alignment: .leading) {
//                                Text(card.name)
//                                Text(card.info)
//                            }
//                            Spacer()
//                            Button(action: {
//                                if let index = sharedInfoList.firstIndex(of: card) {
//                                    sharedInfoList.remove(at: index)
//                                }
//                            }) {
//                                Image(systemName: "trash")
//                                    .foregroundColor(.red)
//                            }
//                        }
//                    }
//                }
//                .listStyle(PlainListStyle())
//
//                Button(action: {
//                    showEditProfile = true
//                }) {
//                    Text("Edit Default Profile")
//                        .padding()
//                        .background(Color.green)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//                
//                Button(action: {
//                    showSharePopup = true
//                }) {
//                    Text("Share Profile")
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//            }
//        }
//        .sheet(isPresented: $showEditProfile) {
//            EditProfileView(profile: $defaultProfile, profileImage: $profileImage, showPopup: $showEditProfile)
//        }
//        .popup(isPresented: $showSharePopup) {
//            SharePopup(showPopup: $showSharePopup, showCustomInfoPopup: $showCustomInfoPopup, sharedInfoList: $sharedInfoList, defaultProfile: defaultProfile)
//        }
//        .popup(isPresented: $showCustomInfoPopup) {
//            CustomInfoPopup(showPopup: $showCustomInfoPopup, sharedInfoList: $sharedInfoList)
//        }
//        .onAppear {
//            // Initialize NFC session here to listen for NFC tags
//            NFCManager.shared.beginScanning { result in
//                switch result {
//                case .success(let message):
//                    showSharePopup = true
//                case .failure(let error):
//                    print("NFC error: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}




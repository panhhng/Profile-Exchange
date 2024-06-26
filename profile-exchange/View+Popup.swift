//
//  View+Popup.swift
//  profile-exchange
//
//  Created by Nhân Nguyễn on 6/26/24.
//

import SwiftUI

extension View {
    func popup<PopupContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder popupContent: @escaping () -> PopupContent
    ) -> some View {
        self
            .overlay(
                ZStack {
                    if isPresented.wrappedValue {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                        popupContent()
                            .frame(maxWidth: 300)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                    }
                }
            )
    }
}



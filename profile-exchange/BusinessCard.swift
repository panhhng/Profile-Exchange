//
//  BusinessCard.swift
//  profile-exchange
//
//  Created by Nhân Nguyễn on 6/26/24.
//

import Foundation

struct BusinessCard: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let info: String
}


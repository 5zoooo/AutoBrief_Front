//
//  DocumentCardModel.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/19/25.
//

import Foundation

struct DocumentCard {
    let title: String
    let category: String
    let date: String 
    let durationInMinutes: Int
    let fileFormat: String
    let isShared = true
    let hasCollaborator = true
}

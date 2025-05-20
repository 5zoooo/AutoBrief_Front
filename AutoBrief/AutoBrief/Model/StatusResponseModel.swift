//
//  StatusResponseModel.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/20/25.
//

import Foundation

struct StatusResponse: Decodable {
    let status: String  // waiting, processing, completed, failed
}

struct StatusErrorResponse: Decodable {
    let detail: StatusErrorDetail
}

struct StatusErrorDetail: Decodable {
    let message: String
}

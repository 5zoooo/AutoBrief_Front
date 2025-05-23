//
//  CTABtn1.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/19/25.
//

import SwiftUI

struct CTABtn1: View {
    var action: () -> Void
    var isActive: Bool
    var btnColor: Color
    var body: some View {
        Button {
            action()
        } label: {
            Text("다음")
                .font(.body1Bold())
                .foregroundStyle(.mainWhite)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(isActive ? Color.first : Color.gray1)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

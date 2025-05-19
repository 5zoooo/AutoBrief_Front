//
//  CTABtn2.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/19/25.
//

import SwiftUI

struct CTABtn2: View {
    var action: () -> Void
    var btnColor: Color
    var isActive: Bool
    var body: some View {
        Button {
            action()
        } label: {
            Text("다음")
                .font(.title2())
                .foregroundStyle(.mainWhite)
                .frame(height: 55)
                .padding(.horizontal, 100)
                .background(isActive ? btnColor : Color.gray1)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

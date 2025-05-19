//
//  SwiftUIView.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/19/25.
//

import SwiftUI

struct CustomHeader: View {
    var action: () -> Void
    var title: String?
    var body: some View {
        HStack() {
            Button(action: {
                action()
            }, label: {
                Image(systemName: "chevron.backward")
                    .font(.body1Bold())
                    .foregroundStyle(Color.mainBlack)
                    .frame(width: 24, height: 24)
            })
            Spacer()
            Text(title ?? "")
                .font(.body1Bold())
            Spacer()
        }
        .padding(.leading,16)
        .padding(.trailing, 40.0)
        .frame(height: 60)
    }
}


#Preview {
    CustomHeader(action: {print("")}, title: "내용")
}

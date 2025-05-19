//
//  MainViewHeader.swift
//  AutoBrief
//
//  Created by 김다빈 on 5/19/25.
//

import SwiftUI

struct MainViewHeader: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                Image(.mainLogo)
                    .frame(width: 16, height: 16)
                
                Text("Auto Brief")
                    .font(.title1())
                    .foregroundStyle(.mainBlack)
                
                Spacer()
            }
            .padding(.leading, 10)
        }
        .background(Color.white)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MainViewHeader()
}

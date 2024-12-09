//
//  CustomNavigationBar.swift
//  VoiceMemo
//
//  Created by Gayoung Kim on 11/28/24.
//

import SwiftUI

struct CustomNavigationBar: View {
    let isDisplayLeftButton: Bool
    let isDisplayRightButton: Bool
    let leftButtonAction: () -> Void
    let rightButtonAction: () -> Void
    let rightButtonType: NavigationButtonType
    
    init(
        isDisplayLeftButton: Bool = true,
        isDisplayRightButton: Bool = true,
        leftButtonAction: @escaping () -> Void = {},
        rightButtonAction: @escaping () -> Void = {},
        rightButtonType: NavigationButtonType = .edit
    ) {
        self.isDisplayLeftButton = isDisplayLeftButton
        self.isDisplayRightButton = isDisplayRightButton
        self.leftButtonAction = leftButtonAction
        self.rightButtonAction = rightButtonAction
        self.rightButtonType = rightButtonType
    }
    
    var body: some View {
        HStack {
            if isDisplayLeftButton {
                Button(action: leftButtonAction) {
                    Image("left_arrow")
                }
            }
            
            Spacer()
            
            if isDisplayRightButton {
                Button(action: rightButtonAction) {
                    if rightButtonType == .close {
                        Image("close")
                        
                    } else {
                        Text(rightButtonType.rawValue)
                            .foregroundColor(.customBlack)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 20)
    }
}

#Preview {
    CustomNavigationBar()
}

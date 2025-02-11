//
//  SettingView.swift
//  VoiceMemo
//
//  Created by Gayoung Kim on 2/11/25.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        VStack {
            TitleView()
            
            Spacer()
                .frame(height: 35)
            
            TotalTapCountView()
            
            Spacer()
                .frame(height: 40)
            
            TotalTabMoveView()
            
            Spacer()
            
        }
    }
}

private struct TitleView: View {
    fileprivate var body: some View {
        HStack {
            Text("설정")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.customBlack)
            
            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.top, 45)
    }
}

private struct TotalTapCountView: View {
    fileprivate var body: some View {
        HStack {
            Spacer()
            
            TabCountView(title: "To do", count: 1)
            
            Spacer()
                .frame(width: 70)
            
            TabCountView(title: "메모", count: 2)
             
            Spacer()
                .frame(width: 70)
            
            TabCountView(title: "음성메모", count: 3)
            
            Spacer()
        }
    }
}

private struct TabCountView: View {
    private var title: String
    private var count: Int
    
    fileprivate init(
        title: String,
        count: Int
    ) {
        self.title = title
        self.count = count
    }
    
    fileprivate var body: some View {
        VStack(spacing: 5) {
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.customBlack)
            
            Text("\(count)")
                .font(.system(size: 30, weight: .medium))
                .foregroundColor(.customBlack)
        }
    }
}

private struct TotalTabMoveView: View {
    fileprivate var body: some View {
        VStack {
            Rectangle()
                .fill(.customGray1)
                .frame(height: 1)
            
            TabMoveView(title: "To do List") {

            }
            
            TabMoveView(title: "메모장") {
                
            }
            
            TabMoveView(title: "음성메모") {
                
            }
            
            TabMoveView(title: "타이머") {
                
            }
            
            Rectangle()
                .fill(.customGray1)
                .frame(height: 1)
        }
    }
}

private struct TabMoveView: View {
    private var title: String
    private var tabAction: () -> Void

    fileprivate init(
        title: String,
        tabAction: @escaping () -> Void
    ) {
        self.title = title
        self.tabAction = tabAction
    }
    
    fileprivate var body: some View {
        Button {
//            tabAction
            
        } label: {
            HStack {
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(.customBlack)
                
                Spacer()
                
                Image("arrowRight")
            }
        }
        .padding(20)
    }
}

#Preview {
    SettingView()
}

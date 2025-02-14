//
//  MemoView.swift
//  VoiceMemo
//
//  Created by Gayoung Kim on 12/19/24.
//

import SwiftUI

struct MemoView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    @StateObject var memoViewModel: MemoViewModel
    @State var isCreateMode: Bool = true
    
    var body: some View {
        ZStack {
            VStack {
                CustomNavigationBar(
                    leftButtonAction: {
                        pathModel.paths.removeLast()
                    },
                    rightButtonAction: {
                        if isCreateMode {
                            memoListViewModel.addMemo(memoViewModel.memo)
                            
                        } else {
                            memoListViewModel.updateMemo(memoViewModel.memo)
                        }
                        
                        pathModel.paths.removeLast()
                    },
                    rightButtonType: isCreateMode ? .create : .complete
                )
                
                MemoTitleInputView(
                    memoViewModel: memoViewModel,
                    isCreateMode: $isCreateMode
                )
                .padding(.top, 20)
                
                MemoContentInputView(memoViewModel: memoViewModel)
                    .padding(.top, 10)
            }
            
            if !isCreateMode {
                RemoveMemoButtonView(memoViewModel: memoViewModel)
                    .padding(.trailing, 20)
                    .padding(.bottom, 10)
            }
        }
    }
}

private struct MemoTitleInputView: View {
    @ObservedObject private var memoViewModel: MemoViewModel
    @FocusState private var isTitleFieldFocused: Bool
    @Binding private var isCreateMode: Bool
    
    fileprivate init(
        memoViewModel: MemoViewModel,
        isCreateMode: Binding<Bool>
    ) {
        self.memoViewModel = memoViewModel
        self._isCreateMode = isCreateMode
    }
    
    fileprivate var body: some View {
        TextField("제목을 입력하세요.",
                  text: $memoViewModel.memo.title
        )
        .font(.system(size: 30))
        .padding(.horizontal, 20)
        .focused($isTitleFieldFocused)
        .onAppear {
            if isCreateMode {
                isTitleFieldFocused = true
            }
        }
    }
}

private struct MemoContentInputView: View {
    @ObservedObject private var memoViewModel: MemoViewModel
    
    fileprivate init(memoViewModel: MemoViewModel) {
        self.memoViewModel = memoViewModel
    }
    
    fileprivate var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $memoViewModel.memo.content)
                .font(.system(size: 20))
            
            if memoViewModel.memo.content.isEmpty {
                Text("내용을 입력하세요.")
                    .font(.system(size: 16))
                    .foregroundColor(.customGray1)
                    .allowsHitTesting(false)
                    .padding(.top, 10)
                    .padding(.leading, 5)
            }
        }
        .padding(.horizontal, 20)
    }
}

private struct RemoveMemoButtonView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    @ObservedObject private var memoViewModel: MemoViewModel
    
    fileprivate init(memoViewModel: MemoViewModel) {
        self.memoViewModel = memoViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    memoListViewModel.removeMemo(memoViewModel.memo)
                    pathModel.paths.removeLast()
                    
                } label: {
                    Image("trash")
                        .resizable()
                        .frame(width: 40, height: 40)
                }

            }
        }
    }
}

#Preview {
    MemoView(
        memoViewModel: .init(
            memo: .init(
                title: "",
                content: "",
                date: Date()
            )
        )
    )
}

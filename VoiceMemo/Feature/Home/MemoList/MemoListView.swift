//
//  MemoListView.swift
//  VoiceMemo
//
//  Created by Gayoung Kim on 12/18/24.
//

import SwiftUI

struct MemoListView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            VStack {
                if !memoListViewModel.memos.isEmpty {
                    CustomNavigationBar (
                        isDisplayLeftButton: false,
                        rightButtonAction: {
                            memoListViewModel.navigationBarRightButtonTapped()
                        },
                        rightButtonType: memoListViewModel.navigationBarRightButtonMode
                    )
                } else {
                    Spacer()
                        .frame(height: 30)
                }

                TitleView()
                    .padding(.top, 20)
                
                if memoListViewModel.memos.isEmpty {
                    AnnouncementView()
                    
                } else {
                    MemoListContentView()
                        .padding(.top, 20)
                }
            }
            
            WriteMemoButtonView()
                .padding(.trailing, 20)
                .padding(.bottom, 50)
        }
        .alert("메모 \(memoListViewModel.removeMemoCount)개 삭제하시겠습니까?",
               isPresented: $memoListViewModel.isDisplayRemoveMemoAlert) {
            Button("삭제", role: .destructive) {
                memoListViewModel.removeButtonTapped()
            }
            Button("취소", role: .cancel) { }
        }
        .onChange(
         of: memoListViewModel.memos,
         perform: { memos in
             homeViewModel.setMemosCount(memos.count)
         }
        )
    }
}

private struct TitleView: View {
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    
    fileprivate var body: some View {
        HStack {
            if memoListViewModel.memos.isEmpty {
                Text("메모를\n추가해보세요.")
                
            } else {
                Text("메모 \(memoListViewModel.memos.count)개가\n있습니다.")
            }
            
            Spacer()
        }
        .font(.system(size: 30, weight: .bold))
        .padding(.leading, 20)
    }
}

private struct AnnouncementView: View {
    fileprivate var body: some View {
        VStack(spacing: 15) {
            Spacer()
            
            Image("pencil")
                .renderingMode(.template)
            Text("\"매운닭발집 리스트\"")
            Text("\"집까지 뛰어서 가기 챌린지\"")
            Text("\"알고리즘 정리\"")
            
            Spacer()
        }
        .font(.system(size: 16))
        .foregroundColor(.customGray2)
    }
}

private struct MemoListContentView: View {
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text("메모 목록")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.leading, 20)
                
                Spacer()
            }
            
            ScrollView {
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(.customGray0)
                        .frame(height: 1)
                    
                    ForEach(memoListViewModel.memos, id: \.self) { memo in
                        MemoCellView(memo: memo)
                    }
                }
            }
        }
    }
}

private struct MemoCellView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    @State private var isRemoveSelected: Bool
    private var memo: Memo
    
    fileprivate init(memo: Memo) {
        _isRemoveSelected = .init(initialValue: false)
        self.memo = memo
    }
    
    fileprivate var body: some View {
        Button {
            pathModel.paths.append(.memoView(isCreateMode: false, memo: memo))
            
        } label: {
            VStack(spacing: 10) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(memo.title)
                            .lineLimit(1)
                            .font(.system(size: 16))
                            .foregroundColor(.customBlack)
                        
                        Text(memo.convertedDate)
                            .font(.system(size: 12))
                            .foregroundColor(.customGrayIcon)
                    }
                    
                    Spacer()
                    
                    if memoListViewModel.isEditMemoMode {
                        Button {
                            isRemoveSelected.toggle()
                            memoListViewModel.memoRemoveSelectedBoxTapped(memo)
                            
                        } label: {
                            isRemoveSelected ? Image("check_fill") : Image("check_empty")
                        }
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 10)
                
                Rectangle()
                    .fill(.customGray0)
                    .frame(height: 1)
            }
        }
    }
}

private struct WriteMemoButtonView: View {
    @EnvironmentObject private var pathModel: PathModel
    
    fileprivate var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    pathModel.paths.append(.memoView(isCreateMode: true, memo: nil))
                    
                } label: {
                    Image("write_btn")
                }

            }
        }
    }
}

#Preview {
    MemoListView()
        .environmentObject(PathModel())
        .environmentObject(MemoListViewModel())
}

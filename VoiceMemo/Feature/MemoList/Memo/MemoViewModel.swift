//
//  MemoViewModel.swift
//  VoiceMemo
//
//  Created by Gayoung Kim on 12/19/24.
//

import Foundation

class MemoViewModel: ObservableObject {
    @Published var memo: Memo
    
    init(memo: Memo) {
        self.memo = memo
    }
}

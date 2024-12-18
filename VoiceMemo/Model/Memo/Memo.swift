//
//  Memo.swift
//  VoiceMemo
//
//  Created by Gayoung Kim on 12/18/24.
//

import Foundation

struct Memo: Hashable {
    var id = UUID()
    var title: String
    var content: String
    var date: Date
    
    var convertedDate: String {
        String("\(date.formattedDay) - \(date.formattedTime)")
    }
}

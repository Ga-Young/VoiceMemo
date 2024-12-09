//
//  Todo.swift
//  VoiceMemo
//
//  Created by Gayoung Kim on 11/28/24.
//

import Foundation

struct Todo: Hashable {
    let id = UUID()
    var title: String
    var time: Date
    var day: Date
    var isSelected: Bool
    
    var convertedDate: String {
        return "\(day.formattedDay) - \(time.formattedTime)"
    }
}

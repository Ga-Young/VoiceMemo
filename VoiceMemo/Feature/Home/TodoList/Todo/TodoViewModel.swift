//
//  TodoViewModel.swift
//  VoiceMemo
//
//  Created by Gayoung Kim on 12/9/24.
//

import Foundation

class TodoViewModel: ObservableObject {
    @Published var title : String
    @Published var time : Date
    @Published var day : Date
    @Published var isDisplayCalendar: Bool
    
    init(title: String = "",
         time: Date = Date(),
         day: Date = Date(),
         isDisplayCalendar: Bool = false
    ) {
        self.title = title
        self.time = time
        self.day = day
        self.isDisplayCalendar = isDisplayCalendar
    }
}

extension TodoViewModel {
    func setIsDisplayCalendar(_ isDisplayCalendar: Bool) {
        self.isDisplayCalendar = isDisplayCalendar
    }
}

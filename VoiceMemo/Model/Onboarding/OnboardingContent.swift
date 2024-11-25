//
//  OnboardingContent.swift
//  VoiceMemo
//
//  Created by Gayoung Kim on 11/25/24.
//

import Foundation

struct OnboardingContent: Hashable {
    var imageFileNAme: String
    var title: String
    var subtitle: String
    
    init(imageFileNAme: String, title: String, subtitle: String) {
        self.imageFileNAme = imageFileNAme
        self.title = title
        self.subtitle = subtitle
    }
}

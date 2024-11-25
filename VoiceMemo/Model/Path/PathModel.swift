//
//  Path.swift
//  VoiceMemo
//
//  Created by Gayoung Kim on 11/25/24.
//

import Foundation

class PathModel: ObservableObject {
    @Published var path: [PathType]
    
    init(path: [PathType] = []) {
        self.path = path
    }
}

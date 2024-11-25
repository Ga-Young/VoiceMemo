//
//  Path.swift
//  VoiceMemo
//
//  Created by Gayoung Kim on 11/25/24.
//

import Foundation

class PathModel: ObservableObject {
    @Published var paths: [PathType]
    
    init(paths: [PathType] = []) {
        self.paths = paths
    }
}

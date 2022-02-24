//
//  ListJokeViewModel.swift
//  project
//
//  Created by carlos alfredo llerena huayta on 23.02.22.
//

import Foundation

struct ListJokeViewModel {
    
    let cells: [JokeCell]
    
    struct JokeCell {
        let title: String
        let icon: String
    }
    
}

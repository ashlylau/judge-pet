//
//  Score.swift
//  judge-pet-2
//
//  Created by Ashly Lau on 3/12/21.
//

import UIKit

class Score {
    var title: String
    var value: Double = 1.0
    var score: Double = 0.0
    
    init(title: String, value: Double) {
        self.title = title
        self.value = value
    }
}

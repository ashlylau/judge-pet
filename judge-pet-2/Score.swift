//
//  Score.swift
//  judge-pet-2
//
//  Created by Ashly Lau on 3/12/21.
//

import UIKit

class Score {
    // Predetermined values.
    // Title of the cell (A/B/C/num CRs/penalty/etc)
    var title: String
    // Value of the cell (0.1/0.2/0.3/1/-1/etc)
    var value: Double = 1.0
    var isElement: Bool

    // Amount entered in the cell
    var count: Double = 0.0

    
    init(title: String, value: Double, isElement: Bool = false) {
        self.title = title
        self.value = value
        self.isElement = isElement
    }
}

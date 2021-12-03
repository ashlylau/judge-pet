//
//  TableCellView.swift
//  judge-pet-2
//
//  Created by Ashly Lau on 3/12/21.
//

import UIKit

class ScoreViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var countTextField: UITextField!
    @IBOutlet var scoreLabel: UILabel!

    var value: Double!
    
    weak var delegate: ScoreViewCellDelegate?
    
    @IBAction func countTextFieldChanged(_ sender: UITextField) {
        print("cell")
        var countString = sender.text ?? "0"
        var count = Double(countString) ?? 0.0
        print(count)
        scoreLabel.text = String(value * count)
        delegate?.cell(self, didUpdateQuantity: value * count)
    }
}

extension ScoreViewCell {
    func configure(title: String, value: Double, delegate: ScoreViewCellDelegate) {
        self.delegate = delegate
        
        self.titleLabel.text = title
        self.scoreLabel.text = "0.0"
        self.countTextField.keyboardType = .numberPad
        self.countTextField.returnKeyType = .done
        self.countTextField.text = ""
        self.value = value
    }
}

protocol ScoreViewCellDelegate: AnyObject {
    func cell(_ cell: ScoreViewCell, didUpdateQuantity quantity: Double)
}

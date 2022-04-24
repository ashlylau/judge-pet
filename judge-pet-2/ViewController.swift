//
//  ViewController.swift
//  judge-pet-2
//
//  Created by Ashly Lau on 2/12/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, ScoreViewCellDelegate  {
    
    func cell(_ cell: ScoreViewCell, didUpdateQuantity quantity: Double) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        self.myData[indexPath.row].count = quantity
        
        calculateTotal()
    }
    
    var myData: [Score] = []

    @IBOutlet var tableView: UITableView!
    @IBOutlet var calculateButton: UIButton!
    @IBOutlet var dScoreLabel: UILabel!
    @IBOutlet var clearButton: UIButton!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.myData = getDefaultData()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreViewCell", for: indexPath) as? ScoreViewCell else {
            fatalError("Unable to dequeue ReminderCell")
        }
        let scoreData = self.myData[indexPath.row]
        
        cell.configure(title: scoreData.title, value: scoreData.value, delegate: self)
        return cell
    }
    
    func calculateTotal() {
        print("calculate total")
        var totalDScore = 0.0
        var numElements = 0.0
        
        // Verify number of elements
        for rowData in self.myData {
            if (rowData.isElement && rowData.count > 0) {
                numElements = numElements + rowData.count
            }
        }
        let shortExercisePenalty = checkNumElements(numElements: Int(numElements))
        
        // Calculate total score
        for rowData in self.myData {
            if (rowData.title == "penalty") {
                rowData.count = rowData.count + shortExercisePenalty
            }
            totalDScore = totalDScore + (rowData.count * rowData.value)
        }
        dScoreLabel.text = String(format: "%.2f", totalDScore)
    }
    
    func checkNumElements(numElements: Int) -> Double {
        print("total elements: \(numElements)")
        // D-score should comprise of 8 elements.
        if (numElements > 8) {
            // show snackbar error
            print("Error - number of elements entered (\(numElements) greater than 8")
            return 0.0
        }
        if (numElements == 7 || numElements == 8) {
            // no deduction
            return 0.0
        } else if (numElements == 5 || numElements == 6) {
            // neutral deduction 4.0
            return 4.0
        } else if (numElements == 3 || numElements == 4) {
            // neutral deduction 6.0
            return 6.0
        } else if (numElements == 1 || numElements == 2) {
            // neutral deduction 8.0
            return 8.0
        } else {
            // neutral deduction 10.0
            return 10.0
        }
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        print("calculate")
        calculateTotal()
    }
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        print("clear")
        self.myData = getDefaultData()
        self.dScoreLabel.text = "0.0"
        tableView?.reloadData()
    }
    private func getDefaultData() -> [Score] {
        return [
            Score(title: "F", value: 0.6, isElement: true),
            Score(title: "E", value: 0.5, isElement: true),
            Score(title: "D", value: 0.4, isElement: true),
            Score(title: "C", value: 0.3, isElement: true),
            Score(title: "B", value: 0.2, isElement: true),
            Score(title: "A", value: 0.1, isElement: true),
            Score(title: "num CRs", value: 0.5),
            Score(title: "total bonus", value: 1.0),
            Score(title: "penalty", value: -1),
        ]
    }

}


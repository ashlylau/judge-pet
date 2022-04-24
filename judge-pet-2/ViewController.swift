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
        self.myData[indexPath.row].score = quantity
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
        for rowData in self.myData {
            totalDScore = totalDScore + rowData.score
        }
        dScoreLabel.text = String(format: "%.2f", totalDScore)
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
            Score(title: "F", value: 0.6),
            Score(title: "E", value: 0.5),
            Score(title: "D", value: 0.4),
            Score(title: "C", value: 0.3),
            Score(title: "B", value: 0.2),
            Score(title: "A", value: 0.1),
            Score(title: "num CRs", value: 0.5),
            Score(title: "total bonus", value: 1.0),
            Score(title: "penalty", value: -1),
        ]
    }

}


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
        
        updateDScore()
    }
    
    var myData: [Score] = []
    var exe: Double = 0.0
    var art: Double = 0.0
    var nd: Double = 0.0
    var d: Double = 0.0

    @IBOutlet var exeValue: UITextField!
    @IBOutlet var artValue: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var calculateButton: UIButton!
    @IBOutlet var clearButton: UIButton!
    @IBOutlet var dvLabel: UILabel!
    @IBOutlet var shortExLabel: UILabel!
    @IBOutlet var dScoreLabel: UILabel!
    @IBOutlet var eScoreLabel: UILabel!
    @IBOutlet var finalScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.myData = getDefaultData()
        tableView.dataSource = self
        tableView.delegate = self
        
        exeValue.keyboardType = .decimalPad
        artValue.keyboardType = .decimalPad
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
    
    private func updateDScore() {
        var dv = 0.0
        var crCv = 0.0
        var numElements = 0.0
        
        for rowData in self.myData {
            if (rowData.isElement && rowData.count > 0) {
                // DV = value of top 8 elements.
                numElements = numElements + rowData.count
                dv = dv + (rowData.count * rowData.value)
            } else if (rowData.title == "N.D.") {
                // Track neutral deductions separately.
                nd = rowData.count
                continue
            } else {
                // Calculate CR + CV separately.
                crCv = crCv + (rowData.count * rowData.value)
            }
        }
        
        // D-score = DV + CR + CV.
        d = dv + crCv
        let shortExercisePenalty = checkNumElements(numElements: Int(numElements))
        
        shortExLabel.text = String(format: "%.2f", shortExercisePenalty)
        dvLabel.text = String(format: "%.2f", dv)
        dScoreLabel.text = String(format: "%.2f", d)
        updateFinalScore()
    }
    
    private func updateEScore() {
        eScoreLabel.text = String(format: "%.2f", 10.0 - exe - art)
        updateFinalScore()
    }
 
    private func updateFinalScore() {
        let finalScore = d + 10.0 - art - exe - nd
        finalScoreLabel.text = String(format: "%.2f", finalScore)
    }

    // Checks that the appropriate number of elements are entered, else
    // returns appropriate short exercise deductions.
    private func checkNumElements(numElements: Int) -> Double {
        print("Total number of elements: \(numElements)")
        // D-score should comprise of 8 or fewer elements.
        if (numElements > 8) {
            // TODO: Show snackbar error.
            print("Error - number of elements entered (\(numElements) greater than 8")
            return 0.0
        }
        if (numElements == 7 || numElements == 8) {
            // no deduction
            return 0.0
        } else if (numElements == 5 || numElements == 6) {
            return 4.0
        } else if (numElements == 3 || numElements == 4) {
            return 6.0
        } else if (numElements == 1 || numElements == 2) {
            return 8.0
        } else {
            return 10.0
        }
    }
    
    @IBAction func exeTextFieldChanged(_ sender: UITextField) {
        let exeString = sender.text ?? "0"
        exe = Double(exeString) ?? 0.0
        updateEScore()
    }
    
    @IBAction func artTextFieldChanged(_ sender: UITextField) {
        let artString = sender.text ?? "0"
        art = Double(artString) ?? 0.0
        updateEScore()
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        updateDScore()
        updateEScore()
    }
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        // Reset data.
        self.myData = getDefaultData()
        self.exe = 0.0
        self.art = 0.0
        self.nd = 0.0
        self.d = 0.0
        
        self.dvLabel.text = "0.0"
        self.shortExLabel.text = "0.0"
        self.dScoreLabel.text = "0.0"
        self.eScoreLabel.text = "0.0"
        self.finalScoreLabel.text = "0.0"
        self.exeValue.text = ""
        self.artValue.text = ""

        tableView?.reloadData()
    }
    
    private func getDefaultData() -> [Score] {
        return [
            Score(title: ".6 F", value: 0.6, isElement: true),
            Score(title: ".5 E", value: 0.5, isElement: true),
            Score(title: ".4 D", value: 0.4, isElement: true),
            Score(title: ".3 C", value: 0.3, isElement: true),
            Score(title: ".2 B", value: 0.2, isElement: true),
            Score(title: ".1 A", value: 0.1, isElement: true),
            Score(title: "CR", value: 0.5),
            Score(title: "CV", value: 1.0),
            Score(title: "N.D.", value: 1.0),
        ]
    }

}


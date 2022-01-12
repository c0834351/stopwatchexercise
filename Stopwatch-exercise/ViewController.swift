//
//  ViewController.swift
//  Stopwatch-exercise
//
//  Created by Sai Snehitha Bhatta on 12/01/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapStore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "lapCell")
       // tableView.dequeueReusableCell(withIdentifier: "lapCell", for: indexPath)
       // cell.textLabel?.text = "Lap \(indexPath.row + 1) \t\t\t\t\t\t\t  00:00.00 "
        cell.textLabel?.text=lapStore[indexPath.row]
        cell.detailTextLabel?.text="Lap \(lapStore.count-indexPath.row)"
        return cell
    } 

    @IBOutlet weak var stopWatch: UILabel!
    @IBOutlet weak var timerBox: UILabel!
    @IBOutlet weak var startStop: UIButton!
    @IBOutlet weak var lapReset: UIButton!
    @IBOutlet weak var lapsTableView: UITableView!
    
    var timer: Timer?
    var minutes: Int = 0
    var seconds: Int = 0
    var fractionSeconds: Int = 0
    var isStarted = true
    var isLap = false
    var counterStyle: String = ""
    var lapStore : [String]=[]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timerBox.text = "00:00.00"
    }
    
    @objc func updatedTimer(){
        fractionSeconds+=1
        if fractionSeconds == 100{
            seconds+=1
            fractionSeconds=0
        }
        if seconds == 60{
            minutes+=1
            seconds=0
        }
        
        let fractionStyle = fractionSeconds > 9 ? "\(fractionSeconds)" : "0\(fractionSeconds)"
        let secondStyle = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minuteStyle = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        counterStyle="\(minuteStyle):\(secondStyle).\(fractionStyle)"
        timerBox.text=counterStyle
        
    }
    
    @IBAction func startStopMethod(_ sender: Any) {
        if isStarted{
            isStarted=false
            timer=Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updatedTimer), userInfo: nil, repeats: true)
            startStop.setTitle("Stop", for: .normal)
            lapReset.setTitle("Lap", for: .normal)
            isLap = true
        }
        else{
            timer?.invalidate()
            isStarted=true
            startStop.setTitle("Start", for: .normal)
            lapReset.setTitle("Reset", for: .normal)
            isLap = false
        }
    }
    
    @IBAction func lapResetMethod(_ sender: Any) {
        if isLap{
            lapStore.insert(counterStyle, at: 0)
            lapsTableView.reloadData()
        }
        else{
            isLap = false
            lapReset.setTitle("Lap", for: .normal)
            lapStore.removeAll()
            lapsTableView.reloadData()
            seconds=0
            fractionSeconds=0
            minutes=0
            counterStyle = "00:00.00"
            timerBox.text=counterStyle
        }
        
    }
    

}


//
//  ViewController.swift
//  retro calculator
//
//  Created by Oscar Arnaiz on 25/03/2016.
//  Copyright © 2016 Oscar Arnaiz. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValSt = ""
    var currentOperation :Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }

    @IBAction func onDividePress(sender: AnyObject) {
        playSound()
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPress(sender: AnyObject) {
        playSound()
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onAddPress(sender: AnyObject) {
        playSound()
        processOperation(Operation.Add)
    }
   
    @IBAction func onSubstractPress(sender: AnyObject) {
        playSound()
        processOperation(Operation.Substract)
    }
    
    @IBAction func onEqualPress(sender: AnyObject) {
        playSound()
        processOperation(currentOperation)
    }
    
    @IBAction func clearBtnPressed(sender: AnyObject) {
        leftValStr = ""
        runningNumber = ""
        rightValSt = ""
        result = ""
        currentOperation = Operation.Empty
        outputLbl.text = "0"
    }
    func processOperation (op: Operation){
        
        if currentOperation != Operation.Empty{
            //Run some maths
            if runningNumber != ""{
                
                rightValSt = runningNumber
                runningNumber = ""
            
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValSt)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValSt)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValSt)!)"
                } else if currentOperation == Operation.Substract {
                    result = "\(Double(leftValStr)! - Double(rightValSt)!)"
                }
                leftValStr = result
                outputLbl.text = result
            }
            currentOperation = op
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
        
    }
    
    func playSound(){
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
    
}


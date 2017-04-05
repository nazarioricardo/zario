//
//  KeyBoardViewController.swift
//  Fretless
//
//  Created by Ricardo Nazario on 2/22/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit
import AudioKit

class KeyBoardViewController: UIViewController, KeyDelegate {
    
    let notes: [UIColor] = [
        UIColor.white,
        UIColor.black,
        UIColor.white,
        UIColor.white,
        UIColor.black,
        UIColor.white,
        UIColor.black,
        UIColor.white,
        UIColor.white,
        UIColor.black,
        UIColor.white,
        UIColor.black
    ]
    
    var keys: [KeyControl] = []
    
    var noteIndex: Int = 0
    
    let a0 = 27.5
    
    var chosenOctave: Int!
    var chosenNoteInterval: Int!
    
    var selectedIndex: Int!
    var numberOfKeys: Int!
    var maxCutoff: Double!
    var minCutoff: Double!
    var twelfthRoot = Float(pow(2, 1/Float(12)))
    
    var lowestFrequency: Float!
    
    var keyBoardHeight: CGFloat {
        get {
            return self.view.bounds.height
        }
    }
    
    var endZoneHeight: CGFloat! {
        get {
            return keyBoardHeight / 5
        }
    }
    
    var midZoneHeight: CGFloat! {
        get {
            return keyBoardHeight - endZoneHeight
        }
    }
    
    var waveform: AKTable!
    var oscillator: AKOscillator!
    var envelope: AKAmplitudeEnvelope!
    var lowPassFilter: AKLowPassFilter!
    
    // Private
    
    func setUpViews() {
        
        lowestFrequency = (Float(a0) * Float(chosenOctave)) * pow(twelfthRoot, Float(chosenNoteInterval))
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let screenXOrigin = screenSize.origin.x
        
        let keyWidth = screenWidth / CGFloat(numberOfKeys)
        let keyHeight = screenHeight
        var xOrigin: CGFloat = screenXOrigin
        
        for keyIndex in Int(xOrigin)..<numberOfKeys {
            
            let color = notes[abs((keyIndex + chosenNoteInterval) % notes.count)]
            print(color.description)
            
            let keyControl = KeyControl(frame: CGRect(x: xOrigin, y: 0, width: keyWidth, height: keyHeight))
            
            keyControl.keyIndex = keyIndex
            keyControl.frequency = lowestFrequency * pow(twelfthRoot, Float(keyIndex))
            keyControl.backgroundColor = color
            keyControl.keyColor = color
            
            self.view.addSubview(keyControl)
            keys.append(keyControl)
            keyControl.keyDelegate = self
            
            noteIndex += 1
            xOrigin += keyWidth
        }
    }
    
    func setUpSound() {
        
        maxCutoff = 880
        minCutoff = 0
        
        oscillator = AKOscillator(waveform: waveform, frequency: 440, amplitude: 1.0, detuningOffset: 0, detuningMultiplier: 0)
        oscillator.start()
        
        lowPassFilter = AKLowPassFilter(oscillator)
        lowPassFilter.dryWetMix = 100
        
        envelope = AKAmplitudeEnvelope(lowPassFilter)
        envelope.attackDuration = 0.01
        envelope.decayDuration = 0.1
        envelope.sustainLevel = 1.0
        envelope.releaseDuration = 0.2
        
        AudioKit.output = envelope
        AudioKit.start()
        
    }
    
    func endSound() {
        
        oscillator.stop()
        AudioKit.stop()
        
    }
    
    // Delegate
    
    func playing(frequency: Double) {
        oscillator.frequency = frequency
        envelope.start()
    }
    
    func affect(yAxis: Double) {
 
        /* WITH ENDZONES ON TOP AND BOTTOM (Would need to multiply getter of midZoneHeight by 2 and change the if condition)
         
         let midZoneY = yAxis - Double(endZoneHeight)
        
         if yAxis > Double(midZoneHeight) {
            lowPassFilter.cutoffFrequency = maxCutoff
        } else if (yAxis < Double(endZoneHeight)) {
            lowPassFilter.cutoffFrequency = minCutoff
        } else {
            lowPassFilter.cutoffFrequency = (midZoneY * (maxCutoff - minCutoff) / Double(midZoneHeight)) + minCutoff
            print("MidZone Y: \(midZoneY)")
        }
        */
        
        if yAxis > Double(midZoneHeight) {
            lowPassFilter.cutoffFrequency = maxCutoff
        } else {
            
            lowPassFilter.cutoffFrequency = ((yAxis * (maxCutoff - minCutoff) / Double(midZoneHeight)) + minCutoff)
        }
    }
    
    func stoppedPlaying() {
        envelope.stop()
    }
    
    // Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.gray
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        switch selectedIndex {
        case 0:
            self.waveform = AKTable(.sine)
        case 1:
            self.waveform = AKTable(.square)
        case 2:
            self.waveform = AKTable(.triangle)
        case 3:
            self.waveform = AKTable(.sawtooth)
        default:
            self.waveform = AKTable(.sawtooth)
            break
        }
        
        switch chosenNoteInterval {
        case -5:
            noteIndex = 3
        case -4:
            noteIndex = 4
        case -3:
            noteIndex = 5
        case -2:
            noteIndex = 6
        case -1:
            noteIndex = 7
        case 0:
            noteIndex = 0
        case 1:
            noteIndex = 1
        case 2:
            noteIndex = 2
        default:
            noteIndex = 0
        }
        
        setUpViews()
        setUpSound()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        for key in keys {
            key.removeFromSuperview()
        }
        endSound()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


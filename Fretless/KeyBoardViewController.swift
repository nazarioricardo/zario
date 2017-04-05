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
    
    let keyColors: [UIColor] = [
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
    
    var noteColorIndex: Int = 0
    
    let a0 = 27.5
    
    var chosenOctave: Int!
    var chosenNoteInterval: Int!
    
    var selectedIndex: Int!
    var numberOfKeys: Int!
    var maxCutoff: Double!
    var minCutoff: Double!
    var twelfthRoot = Float(pow(2, 1/Float(12)))
    
    var waveform: AKTable!
    var oscillator: AKOscillator!
    var envelope: AKAmplitudeEnvelope!
    var lowPassFilter: AKLowPassFilter!
    
    var lowestFrequency: Float {
        get {
            return calculateFreq(root: Float(a0) * calculateOctave(octave: chosenOctave), halfSteps: Float(chosenNoteInterval))
        }
    }
    
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

    // Private
    
    func setUpViews() {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let screenXOrigin = screenSize.origin.x
        
        let keyWidth = screenWidth / CGFloat(numberOfKeys)
        let keyHeight = screenHeight
        var xOrigin: CGFloat = screenXOrigin
        
        for keyIndex in Int(xOrigin)..<numberOfKeys {
            
            let color = keyColors[noteColorIndex % keyColors.count]
            
            let keyControl = KeyControl(frame: CGRect(x: xOrigin, y: 0, width: keyWidth, height: keyHeight))
            
            keyControl.keyIndex = keyIndex
            keyControl.frequency = calculateFreq(root: lowestFrequency, halfSteps: Float(keyIndex))
            keyControl.backgroundColor = color
            keyControl.keyColor = color
            
            self.view.addSubview(keyControl)
            keys.append(keyControl)
            keyControl.keyDelegate = self
            
            noteColorIndex += 1
            xOrigin += keyWidth
        }
    }
    
    func calculateFreq(root: Float, halfSteps: Float) -> Float {
        
        let twelfth = Float(pow(2, 1/Float(12)))
        return root * pow(twelfth, halfSteps)
    }
    
    func calculateOctave(octave: Int) -> Float {
        return Float(pow(Double(2), Double(octave)))
    }
    
    // AudioKit Setup
    
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
    
    // Key Delegate
    
    func xAxis(keyFreq: Float, x: Float) {
        oscillator.frequency = Double(calculateFreq(root: keyFreq, halfSteps: x))
        print("Frequency \(oscillator.frequency)")
        envelope.start()
    }
    
    func yAxis(y: Float) {
        if y > Float(midZoneHeight) {
            lowPassFilter.cutoffFrequency = maxCutoff
        } else {
            
            lowPassFilter.cutoffFrequency = ((y * (maxCutoff - minCutoff) / Double(midZoneHeight)) + minCutoff)
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
        case -9:
            noteColorIndex = 3
        case -7:
            noteColorIndex = 5
        case -5:
            noteColorIndex = 7
        case -4:
            noteColorIndex = 8
        case -2:
            noteColorIndex = 10
        case 0:
            noteColorIndex = 0
        case 2:
            noteColorIndex = 2
        default:
            noteColorIndex = 0
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


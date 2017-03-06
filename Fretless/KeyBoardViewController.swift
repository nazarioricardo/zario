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
    
    var selectedIndex: Int!
    var numberOfKeys: Int = 12
    var lowestFrequency = 220
    var maxCutoff: Double!
    var minCutoff: Double!
    var twelfthRooth = Float(pow(2, 1/Float(12)))
    
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
    
    func setUpViews() {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let screenXOrigin = screenSize.origin.x
        
        let keyWidth = screenWidth / CGFloat(numberOfKeys)
        let keyHeight = screenHeight
        var xOrigin: CGFloat = screenXOrigin
        
        for keyIndex in Int(xOrigin)..<numberOfKeys {
            
            let keyControl = KeyControl(frame: CGRect(x: xOrigin /*+ (keyWidth / 2)*/, y: 0, width: keyWidth, height: keyHeight))
            
            //            let gradient = CAGradientLayer()
            //            let leftColor = UIColor.white
            //            let rightColor = UIColor.lightGray
            //
            //            gradient.colors = [leftColor.cgColor, rightColor.cgColor]
            //            gradient.startPoint = CGPoint(x: 0.0, y: 0)
            //            gradient.endPoint = CGPoint(x: 1.0, y: 0)
            //            gradient.frame = keyControl.bounds
            //
            //            keyControl.layer.insertSublayer(gradient, at: 0)
            
            keyControl.keyIndex = keyIndex
            keyControl.frequency = Float(lowestFrequency) * pow(twelfthRooth, Float(keyIndex))
            self.view.addSubview(keyControl)
            
            keyControl.keyDelegate = self
            
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
    
    func playing(frequency: Double) {
        oscillator.frequency = frequency
        envelope.start()
    }
    
    func affect(yAxis: Double) {
        print("Y coord: \(yAxis)")
        
 
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
        
        print("Cutoff: \(lowPassFilter.cutoffFrequency)")
    }
    
    func stoppedPlaying() {
        envelope.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        
        setUpViews()
        setUpSound()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
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


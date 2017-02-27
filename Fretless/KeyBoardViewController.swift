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
    
    var numberOfKeys: Int = 8
    var lowestFrequency = 220
    var twelfthRooth = Float(pow(2, 1/Float(12)))
    
    var oscillator: AKOscillator!
    var envelope: AKAmplitudeEnvelope!
    
    func setupSound() {
        
        oscillator = AKOscillator(waveform: AKTable(.sawtooth), frequency: 440, amplitude: 1.0, detuningOffset: 0, detuningMultiplier: 0)
        oscillator.start()
        
        envelope = AKAmplitudeEnvelope(oscillator)
        envelope.attackDuration = 0.001
        envelope.decayDuration = 0.1
        envelope.sustainLevel = 1.0
        envelope.releaseDuration = 0.2
        
        AudioKit.output = envelope
        AudioKit.start()
        
    }
    
    func playing(frequency: Double) {
        oscillator.frequency = frequency
        envelope.start()
    }
    
    func stoppedPlaying() {
        envelope.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(twelfthRooth)
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let screenXOrigin = screenSize.origin.x
        
        let keyWidth = screenWidth / CGFloat(numberOfKeys)
        let keyHeight = screenHeight
        var xOrigin: CGFloat = screenXOrigin
        
        for keyIndex in Int(xOrigin)..<numberOfKeys {
            
            let keyControl = KeyControl(frame: CGRect(x: xOrigin /*+ (keyWidth / 2)*/, y: 0, width: keyWidth, height: keyHeight))
            
            let gradient = CAGradientLayer()
            let leftColor = UIColor.white
            let rightColor = UIColor.lightGray
            
            gradient.colors = [leftColor.cgColor, rightColor.cgColor]
            gradient.startPoint = CGPoint(x: 0.0, y: 0)
            gradient.endPoint = CGPoint(x: 1.0, y: 0)
            gradient.frame = keyControl.bounds
            
            keyControl.layer.insertSublayer(gradient, at: 0)
            
            keyControl.keyIndex = keyIndex
            keyControl.frequency = Float(lowestFrequency) * pow(twelfthRooth, Float(keyIndex))
            self.view.addSubview(keyControl)
            
            keyControl.keyDelegate = self
            
            xOrigin += keyWidth
        }
        
        setupSound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


//
//  KeyControl.swift
//  Fretless
//
//  Created by Ricardo Nazario on 2/22/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit

protocol KeyDelegate {
    func playing(frequency: Double)
    func stoppedPlaying()
}

class KeyControl: UIControl {
    
    var keyDelegate: KeyDelegate?
    
    var frequency: Float = Float()
    var keyIndex: Int = Int()
    
    var twelfthRooth = Float(pow(2, 1/Float(12)))
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touching the key: \(frequency)")
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        keyDelegate?.playing(frequency: Double(frequency))
        return true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var xLocation: CGPoint!
        
        for touch in touches {
            xLocation = touch.location(in: self)
        }
        
        let xMovement = xLocation.x/self.bounds.width
        
        keyDelegate?.playing(frequency: Double(Float(frequency) * pow(twelfthRooth, Float(xMovement))))
        
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let location = touch.location(in: self)
        
        return false
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        keyDelegate?.stoppedPlaying()
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

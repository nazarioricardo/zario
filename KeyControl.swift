//
//  KeyControl.swift
//  Fretless
//
//  Created by Ricardo Nazario on 2/22/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit

protocol KeyDelegate {
    func xAxis(keyFreq: Float, x: Float)
    func yAxis(y: Float)
    func stoppedPlaying()
}

class KeyControl: UIControl {

    var keyColor: UIColor!
    var keyDelegate: KeyDelegate?
    
    var frequency: Float = Float()
    var keyIndex: Int = Int()
    
    var twelfthRooth = Float(pow(2, 1/Float(12)))
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        self.backgroundColor = UIColor.lightGray
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        keyDelegate?.xAxis(keyFreq: frequency, x: Float(touch.location(in: self).x))
        return true
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var xLocation: CGFloat!
        var yLocation: CGFloat!
        
        for touch in touches {
            xLocation = touch.location(in: self).x
            yLocation = touch.location(in: self).y
        }
        
        let xMovement = xLocation/self.bounds.width
        
        keyDelegate?.xAxis(keyFreq: frequency, x: Float(xMovement))
        keyDelegate?.yAxis(y: Float(yLocation))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.backgroundColor = keyColor
        keyDelegate?.stoppedPlaying()
    }

    func setUpView() {
        self.layer.cornerRadius = 10
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
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

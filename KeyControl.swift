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
    func affect(yAxis: Double)
    func stoppedPlaying()
}

class KeyControl: UIControl {
    
    let gradient = CAGradientLayer()
    var leftColor = UIColor.clear
    var rightColor = UIColor.lightGray
    
    var keyDelegate: KeyDelegate?
    
    var frequency: Float = Float()
    var keyIndex: Int = Int()
    
    var twelfthRooth = Float(pow(2, 1/Float(12)))
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        gradient.colors = [leftColor.cgColor, UIColor.white.cgColor]
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        keyDelegate?.playing(frequency: Double(frequency))
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
        
        keyDelegate?.playing(frequency: Double(frequency * pow(twelfthRooth, Float(xMovement))))
        keyDelegate?.affect(yAxis: Double(yLocation))
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        keyDelegate?.stoppedPlaying()
        gradient.colors = [leftColor.cgColor, rightColor.cgColor]
    }

    func setUpView() {
    
//        self.backgroundColor = UIColor.black
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        
        gradient.colors = [leftColor.cgColor, rightColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0)
        gradient.frame = self.bounds
        
//        self.layer.insertSublayer(gradient, at: 0)
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

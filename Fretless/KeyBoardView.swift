//
//  KeyBoardView.swift
//  Fretless
//
//  Created by Ricardo Nazario on 4/27/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit

protocol KeyBoardDelegate {
    func xAxis(keyFreq: Float, x: Float)
    func yAxis(y: Float)
    func stoppedPlaying()
}

class KeyBoardView: UIControl {
    
    var delegate: KeyBoardDelegate?
    
    var frequency: Float = Float()
    
    var touchViewWidth: CGFloat!
    var touchViewIndicator = TouchIndicatorView()
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let xTouch = touch.location(in: self).x
        let yTouch = touch.location(in: self).y

        delegate?.xAxis(keyFreq: frequency, x: Float((xTouch - touchViewWidth/2)/touchViewWidth))
        delegate?.yAxis(y: Float(touch.location(in: self).y))
        
        createTouchIndicator(x: xTouch, y: yTouch)
        
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let xTouch = touch.location(in: self).x
        let yTouch = touch.location(in: self).y
        delegate?.xAxis(keyFreq: frequency, x: Float((xTouch - touchViewWidth/2)/touchViewWidth))
        delegate?.yAxis(y: Float(touch.location(in: self).y))
        
        let touchViewCenter = CGPoint(x: touch.location(in: self).x, y: self.bounds.midY)
        touchViewIndicator.center.x = touchViewCenter.x
        
        UIView.animate(withDuration: 0.01,
                       animations: {
                        self.touchViewIndicator.frame.size.height = yTouch + 200
                        self.touchViewIndicator.backgroundColor = UIColor(colorLiteralRed: 255/255, green: 125/255, blue: 125/255, alpha: Float(yTouch/1))
        },
                       completion: nil)
    
        
        
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        delegate?.stoppedPlaying()
        touchViewIndicator.removeFromSuperview()
    }
    
    func createTouchIndicator(x: CGFloat, y: CGFloat) {
        
        let touchPoint = CGPoint(x: x, y: y)
        
        touchViewIndicator = TouchIndicatorView.init(frame: CGRect(x: touchPoint.x - (touchViewWidth / 2), y: self.bounds.minY - 200, width: touchViewWidth, height: touchPoint.y + 200))
        
        touchViewIndicator.backgroundColor = UIColor.init(colorLiteralRed: 255/255, green: 125/255, blue: 125/255, alpha: 0.0)
        touchViewIndicator.layer.cornerRadius = touchViewWidth/4
        
        self.addSubview(touchViewIndicator)
    }
    
    func setUpView() {
//        createTouchIndicator(x: 0, y: 0)
        self.backgroundColor = UIColor.clear
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

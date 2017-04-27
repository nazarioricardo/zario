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
    var touchViewIndicator: TouchIndicatorView!
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let xTouch = touch.location(in: self).x

        delegate?.xAxis(keyFreq: frequency, x: Float((xTouch - touchViewWidth/2)/touchViewWidth))
        delegate?.yAxis(y: Float(touch.location(in: self).y))
        
        let touchViewCenter = CGPoint(x: touch.location(in: self).x, y: self.bounds.midY)
        createTouchIndicator(touchPoint: touchViewCenter)

        
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let xTouch = touch.location(in: self).x
        
        delegate?.xAxis(keyFreq: frequency, x: Float((xTouch - touchViewWidth/2)/touchViewWidth))
        delegate?.yAxis(y: Float(touch.location(in: self).y))
        
        let touchViewCenter = CGPoint(x: touch.location(in: self).x, y: self.bounds.midY)
        touchViewIndicator.center = touchViewCenter
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        delegate?.stoppedPlaying()
        touchViewIndicator.removeFromSuperview()
    }
    
    
    func createTouchIndicator(touchPoint: CGPoint) {
        touchViewIndicator = TouchIndicatorView.init(frame: CGRect(x: touchPoint.x - (touchViewWidth / 2), y: self.bounds.maxY, width: touchViewWidth, height: self.bounds.height))
        self.addSubview(touchViewIndicator)
    }
    
    func setUpView() {
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

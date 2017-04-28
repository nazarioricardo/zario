//
//  TouchIndicatorView.swift
//  Fretless
//
//  Created by Ricardo Nazario on 4/27/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit

protocol IndicatorDelegate {
    func xAxis(keyFreq: Float, x: Float)
    func yAxis(y: Float)
    func stoppedPlaying()
}

class TouchIndicatorView: UIControl {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    

    func setUpView() {
//        self.backgroundColor = UIColor.lightGray
        
        self.isOpaque = true
    
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

//
//  SegmentedController.swift
//  Fretless
//
//  Created by Ricardo Nazario on 5/3/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit

@IBDesignable class SegmentedController: UIControl, ThumbDelegate {
    
    private var labels = [UILabel]()
    var thumbView = ThumbView()
    
    public var items: [String] = ["Item 1", "Item 2", "Item 3"] {
        didSet {
            setupLabels()
        }
    }
    
    var selectedIndex: Int! = 0 {
        didSet {
            displayNewSelectedIndex()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        
        layer.cornerRadius = frame.height / 2
        layer.borderColor = UIColor(white: 1.0, alpha: 0.5).cgColor
        layer.borderWidth = 1
        
        backgroundColor = UIColor(white: 1.0, alpha: 0.3)
        
        setupLabels()
        insertSubview(thumbView, at: 0)
    }
    
    func setupLabels() {
        
        for label in labels {
            label.removeFromSuperview()
        }
        
        labels.removeAll(keepingCapacity: true)
        
        for index in 1...items.count {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            label.text = items[index - 1]
            label.textAlignment = .center
            label.textColor = UIColor(white: 0.5, alpha: 1.0)
            label.font = label.font.withSize(15)
            self.addSubview(label)
            labels.append(label)
        }
        
        thumbView.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var selectFrame = self.bounds
        let newWidth = CGFloat(selectFrame.width) / CGFloat(items.count)
        selectFrame.size.width = newWidth
        thumbView.frame = selectFrame
        thumbView.backgroundColor = UIColor.white
        thumbView.layer.cornerRadius = thumbView.frame.height / 2
        
        let labelHeight = self.bounds.height
        let labelWidth = self.bounds.width / CGFloat(labels.count)
        
        for index in 0...labels.count - 1 {
            
            let label = labels[index]
            let xPosition = CGFloat(index) * labelWidth
            label.frame = CGRect(x: xPosition, y: 0, width: labelWidth, height: labelHeight)
        }
        
        self.displayNewSelectedIndex()
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let location = touch.location(in: self)
        var calculatedIndex: Int?
        
        for (index, item) in labels.enumerated() {
            
            if item.frame.contains(location) {
                calculatedIndex = index
            }
        }
        
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActions(for: .valueChanged)
        }
        
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        moveIndicatorTo(touchX: location.x)

        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        let location = touch?.location(in: superview)
        var calculatedIndex: Int?
        
        for (index, item) in labels.enumerated() {
            
            if item.frame.contains(CGPoint(x: (location?.x)!, y: self.center.y)) {
                calculatedIndex = index
            }
            
            if calculatedIndex != nil {
                selectedIndex = calculatedIndex!
                sendActions(for: .valueChanged)
            }
        }
    }
    
    func startedTouchingThumbView(location: CGFloat) {
        var calculatedIndex: Int?
        
        for (index, item) in labels.enumerated() {
            
            if item.frame.contains(CGPoint(x: location, y: self.center.y)) {
                calculatedIndex = index
            }
            
            if calculatedIndex != nil {
                selectedIndex = calculatedIndex!
                sendActions(for: .valueChanged)
            }
        }
    }
    
    func isTouchingThumbView(location: CGFloat) {
        moveIndicatorTo(touchX: location)
    }
    
    func didEndTouchInThumbView(location: CGFloat) {
        var calculatedIndex: Int?
        
        for (index, item) in labels.enumerated() {
            
            if item.frame.contains(CGPoint(x: location, y: self.center.y)) {
                calculatedIndex = index
            }
            
            if calculatedIndex != nil {
                selectedIndex = calculatedIndex!
                sendActions(for: .valueChanged)
            }
        }
    }
    
    func moveIndicatorTo(touchX: CGFloat) {
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.5,
                       options: .allowAnimatedContent,
                       animations: {
                        
                        self.thumbView.center.x = touchX
        },
                       completion: nil)
        
    }
    
    func displayNewSelectedIndex() {
        
        let label = labels[selectedIndex]
        
        UIView.animate(withDuration: 0.7,
                       delay: 0.0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.5,
                       options: .allowAnimatedContent,
                       animations: {
                        
                        self.thumbView.frame = label.frame
                        self.thumbView.center.x = label.center.x
        },
                       completion: nil)
        
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

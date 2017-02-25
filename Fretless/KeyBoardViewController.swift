//
//  KeyBoardViewController.swift
//  Fretless
//
//  Created by Ricardo Nazario on 2/22/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit

class KeyBoardViewController: UIViewController {
    
    var numberOfKeys: Int = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
            self.view.addSubview(keyControl)
            
            xOrigin += keyWidth
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


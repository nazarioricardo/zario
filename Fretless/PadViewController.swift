//
//  PadViewController.swift
//  Fretless
//
//  Created by Ricardo Nazario on 2/22/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit

class PadViewController: UIViewController {
    
    var numberOfKeys: Int = 12

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let keyWidth = self.view.layer.bounds.width / CGFloat(numberOfKeys)
        let keyHeight = self.view.layer.bounds.height
        var xOrigin: CGFloat = self.view.layer.bounds.minX
        
        for keyIndex in Int(xOrigin)..<numberOfKeys {
            
            print(xOrigin)
        
            let keyControl = KeyControl(frame: CGRect(x: xOrigin + (keyWidth/2), y: 0, width: keyWidth, height: keyHeight))
            self.view.addSubview(keyControl)
            xOrigin += keyWidth
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


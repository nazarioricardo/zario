//
//  BaseViewController.swift
//  Fretless
//
//  Created by Ricardo Nazario on 2/24/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit
import AudioKit

class BaseViewController: UIViewController {
    
    var keyboardVC: KeyBoardViewController!
    
    @IBOutlet weak var waveformSelector: UISegmentedControl!
    @IBOutlet weak var noteSelector: UISegmentedControl!
    @IBOutlet weak var octaveSlider: UISlider!
    @IBOutlet weak var rangeSlider: UISlider!
    @IBOutlet weak var attackSlider: UISlider!
    @IBOutlet weak var releaseSlider: UISlider!

    @IBOutlet weak var octaveLabel: UILabel!
    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    
    var octaveMultiplier: Int!
    
    @IBAction func octaveSliderChanged(_ sender: Any) {
        octaveMultiplier = Int(self.octaveSlider.value)
        octaveLabel.text = String(Int(self.octaveSlider.value))
    }
    
    @IBAction func rangeSliderChanged(_ sender: Any) {
        rangeLabel.text = String(Int(rangeSlider.value))
    }
    
    @IBAction func attackSliderChanged(_ sender: Any) {
        attackLabel.text = String(attackSlider.value)
    }
    
    @IBAction func releaseSliderChanged(_ sender: Any) {
        releaseLabel.text = String(releaseSlider.value)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition:
            {(context: UIViewControllerTransitionCoordinatorContext) in
            
            if UIDevice.current.orientation.isPortrait {
                self.keyboardVC.dismiss(animated: true, completion: nil)
            }
        },
                            completion:
            { (context: UIViewControllerTransitionCoordinatorContext) in
                
                self.keyboardVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "KeyBoardViewController") as! KeyBoardViewController
                
                if UIDevice.current.orientation.isLandscape {
                                    
                    self.keyboardVC.chosenOctave = self.octaveMultiplier
                                    
                    switch self.noteSelector.selectedSegmentIndex {
                        case 0:
                            self.keyboardVC.chosenNoteInterval = -9
                        case 1:
                            self.keyboardVC.chosenNoteInterval = -7
                        case 2:
                            self.keyboardVC.chosenNoteInterval = -5
                        case 3:
                            self.keyboardVC.chosenNoteInterval = -4
                        case 4:
                            self.keyboardVC.chosenNoteInterval = -2
                        case 5:
                            self.keyboardVC.chosenNoteInterval = 0
                        case 6:
                            self.keyboardVC.chosenNoteInterval = 2
                        default:
                            self.keyboardVC.chosenNoteInterval = 0
                    }
                    
                    self.keyboardVC.modalTransitionStyle = .crossDissolve
                    self.keyboardVC.selectedIndex = self.waveformSelector.selectedSegmentIndex
                    self.keyboardVC.numberOfKeys = Int(self.rangeSlider.value)
                    self.keyboardVC.attack = self.attackSlider.value
                    self.keyboardVC.release = self.releaseSlider.value
                    
                    self.present(self.keyboardVC, animated: true, completion: nil)
                }
            })
    }
    
    func addGradient() {
        
        let gradient = CAGradientLayer()
        
        let leftColor = UIColor.white.withAlphaComponent(0.0)
        let rightColor = UIColor.white.withAlphaComponent(0.2)
        gradient.colors = [leftColor.cgColor, rightColor.cgColor]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = self.view.bounds
        
        self.view.layer.addSublayer(gradient)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 225/255, green: 240/255, blue: 239/255, alpha: 1)
        // self.waveformSelector.backgroundColor = UIColor(red: 18/255, green: 65/255, blue: 62/255, alpha: 1)
        addGradient()
        
        octaveMultiplier = Int(self.octaveSlider.value)
        octaveLabel.text = String(Int(self.octaveSlider.value))
        attackLabel.text = String(self.attackSlider.value)
        releaseLabel.text = String(self.releaseSlider.value)
        waveformSelector.selectedSegmentIndex = 3
        noteSelector.selectedSegmentIndex = 5
        Audiobus.start()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
